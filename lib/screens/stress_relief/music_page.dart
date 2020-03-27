import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stress_app/data/User.dart';
import 'package:stress_app/tools/Json.dart';
import 'package:video_player/video_player.dart';

class MusicPage extends StatefulWidget {
  static AudioPlayer player;
  static File currentFile;
  static bool playing = false;
  static bool playerSet = false;
  static bool loop = false;
  static int currentPos = 0;
  static String currentlyPlaying = '';
  static List<String> musicList = new List();

  MusicPage(this.isWidget, {Key key, this.title}) : super(key: key);

  final isWidget;
  final String title;

  @override
  _MusicPageState createState() => _MusicPageState(isWidget, player);
}

class _MusicPageState extends State<MusicPage> {
  _MusicPageState(this.isWidget, this.player);

  final isWidget;

  VideoPlayerController videoController;

  final AudioPlayer player;

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
    videoController = VideoPlayerController.asset('assets/videos/Music_Animation.mp4')
      ..initialize().then((_) {
        videoController.setLooping(true);
        setState(() {});
      });

    player.onPlayerCompletion.listen((event) async {
      MusicPage.currentPos == MusicPage.musicList.length - 1 ? MusicPage.currentPos = 0 : MusicPage.currentPos++;
      MusicPage.loop ? await player.play(MusicPage.currentFile.path, isLocal: true) : _loadMusic(MusicPage.musicList[MusicPage.currentPos]);
    });

    if (User.currentUser.musicList != null) MusicPage.musicList = User.currentUser.musicList;
  }

  @override
  Widget build(BuildContext context) {
    return isWidget ? _widget() : _page();
  }

  Widget _page() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xff101010),
        ),
        child: ListView.separated(
          itemCount: names.length + 1,
          separatorBuilder: (BuildContext context, int index) => Divider(
            color: Colors.white,
          ),
          itemBuilder: (BuildContext context, int index) {
            return index == 0 ?
            Container(
              height: ((MediaQuery.of(context).size.height) / 2),
            )
                : _createTile(names[index - 1]);
          },
        ),
      ),
      bottomNavigationBar: _BottomBar(this),
    );
  }

  Widget _widget() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff424242),
        ),
        child: Column(
          children: <Widget>[
            _MediaPlayer(this),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                MusicPage.currentlyPlaying == '' ? 'Nothing Playing' : MusicPage.currentlyPlaying.replaceAll('_', ' '),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: 162,
              width: 288,
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(
                  width: 5,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: videoController.value.initialized ?
              AspectRatio(
                aspectRatio: videoController.value.aspectRatio,
                child: VideoPlayer(videoController),
              ) : Container(),
            ),
          ],
        )
      ),
    );
  }

  Widget _createTile(String name) {
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
        color: MusicPage.musicList.contains(name) ? Colors.green : Colors.white,
        icon: Icon(Icons.add),
        onPressed: () {
          setState(() {
            MusicPage.musicList.contains(name) ? MusicPage.musicList.remove(name) : MusicPage.musicList.add(name);
          });
        },
      ),
      onTap: () {
        player.stop();
        _loadMusic(name);
      },
    );
  }

  Future _loadMusic(String name) async {
    MusicPage.currentFile = new File('${(await getTemporaryDirectory()).path}/$name.mp3');
    await MusicPage.currentFile.writeAsBytes((await _loadAsset(name)).buffer.asUint8List());
    final result = await player.play(MusicPage.currentFile.path, isLocal: true);
    setState(() {
      MusicPage.playerSet = MusicPage.playing = result == 1;
      MusicPage.currentlyPlaying = name;
    });
  }

  Future<ByteData> _loadAsset(String name) async {
    return await rootBundle.load('assets/music/$name.mp3');
  }
}

class _BottomBar extends StatelessWidget {
  final _MusicPageState parent;

  _BottomBar(this.parent);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Ink(
        color: Color(0xff000000),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  splashColor: Colors.transparent,
                  color: Colors.white,
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                IconButton(
                  splashColor: Colors.transparent,
                  color: Colors.transparent,
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {},
                ),
              ],
            ),
            _MediaPlayer(parent),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  splashColor: Colors.transparent,
                  color: MusicPage.loop ? Colors.green : Colors.white,
                  icon: Icon(Icons.loop),
                  onPressed: () {
                    parent.setState(() {
                      MusicPage.loop = !MusicPage.loop;
                    });
                  },
                ),
                IconButton(
                  splashColor: Colors.transparent,
                  color: Colors.white,
                  icon: Icon(Icons.save),
                  onPressed: () {
                    User.currentUser.musicList = MusicPage.musicList;
                    Json.saveUser(User.currentUser);
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration(seconds: 2),
                        content: Text(
                          'Saved your playlist',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _MediaPlayer extends StatelessWidget {
  final _MusicPageState parent;

  _MediaPlayer(this.parent);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        IconButton(
          splashColor: Colors.transparent,
          color: Colors.white,
          icon: Icon(Icons.fast_rewind),
          onPressed: () async {
            if (MusicPage.playerSet) {
              MusicPage.currentPos == 0 ? MusicPage.currentPos = MusicPage.musicList.length - 1 : MusicPage.currentPos--;
              parent._loadMusic(MusicPage.musicList[MusicPage.currentPos]);
            }
          },
        ),
        IconButton(
          splashColor: Colors.transparent,
          color: Colors.white,
          icon: MusicPage.playing ? Icon(Icons.pause) : Icon(Icons.play_arrow),
          onPressed: () {
            if (MusicPage.playerSet) {
              if (!MusicPage.playing) {
                parent.player.resume();
                parent.videoController.play();
                parent.setState(() {
                  MusicPage.playing = true;
                });
              } else {
                parent.player.pause();
                parent.videoController.pause();
                parent.setState(() {
                  MusicPage.playing = false;
                });
              }
            } else if(MusicPage.musicList.length > 0) {
              parent.videoController.play();
              parent._loadMusic(MusicPage.musicList[MusicPage.currentPos]);
            }
          },
        ),
        IconButton(
          splashColor: Colors.transparent,
          color: Colors.white,
          icon: Icon(Icons.fast_forward),
          onPressed: () async {
            if (MusicPage.playerSet) {
              MusicPage.currentPos == MusicPage.musicList.length - 1 ? MusicPage.currentPos = 0 : MusicPage.currentPos++;
              parent._loadMusic(MusicPage.musicList[MusicPage.currentPos]);
            }
          },
        ),
      ],
    );
  }
}