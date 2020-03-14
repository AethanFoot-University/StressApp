import 'dart:io';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class MusicPage extends StatefulWidget {
  MusicPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MusicPageState createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> with TickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  Color color = Color(0xff101010);

  AudioPlayer player;
  File currentFile;
  bool playing = false;
  bool playerSet = false;

  Color randColor() {
    Random rand = new Random();
    return Color.fromARGB(255, rand.nextInt(255), rand.nextInt(255), rand.nextInt(255));
  }

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    player.onPlayerCompletion.listen((event) async {
      final result = await player.play(currentFile.path, isLocal: true);
    });

    controller = AnimationController(duration: const Duration(seconds: 2), vsync: this);
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        color = Color(0xff101010);
      }
    });
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceIn, reverseCurve: Curves.bounceOut);
    animation.addListener(() {
      setState(() {
        color = randColor();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            color: color,
          ),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: <Widget>[
                  RaisedButton(
                    child: Text(
                        'Tranquility'
                    ),
                    onPressed: () {
                      player.stop();
                      loadMusic('assets/music/Tranquility.mp3', 'Tranquility.mp3');
                    },
                  ),
                  RaisedButton(
                    child: Text(
                        'Relaxing Green Nature'
                    ),
                    onPressed: () {
                      player.stop();
                      loadMusic('assets/music/Relaxing_Green_Nature.mp3', 'Relaxing_Green_Nature.mp3');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    bottomNavigationBar: BottomBar(this),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    player.stop();
    super.dispose();
  }

  Future loadMusic(String dir, String filePath) async {
    currentFile = new File('${(await getTemporaryDirectory()).path}/$filePath');
    await currentFile.writeAsBytes((await loadAsset(dir)).buffer.asUint8List());
    final result = await player.play(currentFile.path, isLocal: true);
    setState(() {
      playerSet = playing = result == 1;
    });
  }

  Future<ByteData> loadAsset(String dir) async {
    return await rootBundle.load(dir);
  }
}

class BottomBar extends StatelessWidget {
  final _MusicPageState parent;

  BottomBar(this.parent);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Ink(
        color: Color(0xff000000),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              color: Colors.white,
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.fast_rewind),
                  onPressed: () async {
                    if (parent.playerSet) {
                      print(await parent.player.getCurrentPosition());
                      parent.player.seek(Duration(milliseconds: await parent.player.getCurrentPosition() - 5000));
                    }
                  },
                ),
                IconButton(
                  color: Colors.white,
                  icon: parent.playing ? Icon(Icons.pause) : Icon(Icons.play_arrow),
                  onPressed: () {
                    if (parent.playerSet) {
                      if (!parent.playing) {
                        parent.player.resume();
                        parent.setState(() {
                          parent.playing = true;
                        });
                      } else {
                        parent.player.pause();
                        parent.setState(() {
                          parent.playing = false;
                        });
                      }
                    }
                  },
                ),
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.fast_forward),
                  onPressed: () async {
                    if (parent.playerSet) {
                      print(await parent.player.getCurrentPosition());
                      parent.player.seek(Duration(milliseconds: await parent.player.getCurrentPosition() + 5000));
                    }
                  },
                ),
              ],
            ),
            IconButton(
              color: Colors.transparent,
              icon: Icon(Icons.search),
              onPressed: () {
                //parent.controller.forward();
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Your Are A Genius',
                      //'RAVE!!!!!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  )
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}