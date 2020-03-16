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

class _MusicPageState extends State<MusicPage> {
  AudioPlayer player;
  File currentFile;
  bool playing = false;
  bool playerSet = false;
  bool loop = false;
  int currentPos = 0;
  List<String> musicList = new List();

  List<String> names = [
    'Relaxing_Green_Nature',
    'Tranquility',
    'Beautiful_Memories',
    'Deep_Meditation',
    'Elevator_Ride',
    'Elven_Forest',
    'Fireside_Date',
    'Healing_Water',
    'In_The_Light',
    'Not_Much_To_Say',
    'Quiet_Time',
    'The_Lounge',
    'The_Quiet_Morning',
    'Warm_Light',
  ];

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    player.onPlayerCompletion.listen((event) async {
      currentPos == musicList.length - 1 ? currentPos = 0 : currentPos++;
      loop ? await player.play(currentFile.path, isLocal: true) : loadMusic(musicList[currentPos]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            color: Color(0xff101010),
          ),
        child: ListView.separated(
          itemCount: names.length + 1,
          separatorBuilder: (BuildContext context, int index) => Divider(),
          itemBuilder: (BuildContext context, int index) {
            return index == 0 ?
            Container(
              height: ((MediaQuery.of(context).size.height) / 2),
            )
                : createTile(names[index - 1]);
          },
        ),
      ),
      bottomNavigationBar: BottomBar(this),
    );
  }

  @override
  void dispose() {
    player.stop();
    super.dispose();
  }

  Widget createTile(String name) {
    String title = name.replaceAll('_', ' ');
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: IconButton(
        color: musicList.contains(name) ? Colors.green : Colors.white,
        icon: Icon(Icons.add),
        onPressed: () {
          setState(() {
            musicList.contains(name) ? musicList.remove(name) : musicList.add(name);
          });
        },
      ),
      onTap: () {
        player.stop();
        loadMusic(name);
      },
    );
  }

  Future loadMusic(String name) async {
    currentFile = new File('${(await getTemporaryDirectory()).path}/$name.mp3');
    await currentFile.writeAsBytes((await loadAsset(name)).buffer.asUint8List());
    final result = await player.play(currentFile.path, isLocal: true);
    setState(() {
      playerSet = playing = result == 1;
    });
  }

  Future<ByteData> loadAsset(String name) async {
    return await rootBundle.load('assets/music/$name.mp3');
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
                      parent.currentPos == 0 ? parent.currentPos = parent.musicList.length - 1 : parent.currentPos--;
                      parent.loadMusic(parent.musicList[parent.currentPos]);
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
                    } else if(parent.musicList.length > 0) {
                      parent.loadMusic(parent.musicList[parent.currentPos]);
                    }
                  },
                ),
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.fast_forward),
                  onPressed: () async {
                    if (parent.playerSet) {
                      parent.currentPos == parent.musicList.length - 1 ? parent.currentPos = 0 : parent.currentPos++;
                      parent.loadMusic(parent.musicList[parent.currentPos]);
                    }
                  },
                ),
              ],
            ),
            IconButton(
              color: parent.loop ? Colors.green : Colors.white,
              icon: Icon(Icons.loop),
              onPressed: () {
                parent.setState(() {
                  parent.loop = !parent.loop;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}