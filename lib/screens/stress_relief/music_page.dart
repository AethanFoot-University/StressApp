import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:path_provider/path_provider.dart';

import 'package:stress_app/style/theme_colours.dart';
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
  static String previouslyPlayed = '';
  static List<String> musicList = new List();

  MusicPage({@required this.isWidget});

  final isWidget;

  @override
  _MusicPageState createState() => _MusicPageState(isWidget);
}

class _MusicPageState extends State<MusicPage> {
  _MusicPageState(this.isWidget);

  final isWidget;

  VideoPlayerController videoController;

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

    MusicPage.player.onPlayerCompletion.listen((event) async {
      MusicPage.currentPos == MusicPage.musicList.length - 1 ? MusicPage.currentPos = 0 : MusicPage.currentPos++;
      MusicPage.loop ? await MusicPage.player.play(MusicPage.currentFile.path, isLocal: true) : _loadMusic(MusicPage.musicList[MusicPage.currentPos]);
    });

    if (User.currentUser.musicList != null) MusicPage.musicList = User.currentUser.musicList;
  }

  @override
  Widget build(BuildContext context) {
    MusicPage.playing ? MusicPage.player.resume() : MusicPage.player.pause();

    return isWidget ? _widget() : _page();
  }

  Widget _page() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: ThemeColours.SECONDARY_BACKGROUND_COLOR,
        ),
        child: ListView.separated(
          itemCount: names.length + 1,
          separatorBuilder: (BuildContext context, int index) => Divider(
            color: Colors.grey,
            thickness: 2.0,
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
    MusicPage.playing ? videoController.play() : videoController.pause();

    return Container(
        decoration: BoxDecoration(
          color: ThemeColours.PRIMARY_BACKGROUND_COLOR,
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
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: videoController.value.initialized ?
              Container(
                height: 162.0,
                width: 162.0 * videoController.value.aspectRatio,
                child: VideoPlayer(videoController),
              ) : Container(),
            ),
          ],
        )
    );
  }

  Widget _createTile(String name) {
    String title = name.replaceAll('_', ' ');
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: name == MusicPage.currentlyPlaying ? Colors.green : Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: IconButton(
        color: MusicPage.musicList.contains(name) ? Colors.green : Colors.white,
        icon: Icon(OMIcons.add),
        onPressed: () {
          setState(() {
            MusicPage.musicList.contains(name) ? MusicPage.musicList.remove(name) : MusicPage.musicList.add(name);
          });
        },
      ),
      onTap: () {
        _loadMusic(name);
      },
    );
  }

  Future _loadMusic(String name) async {
    MusicPage.currentFile = new File('${(await getTemporaryDirectory()).path}/$name.mp3');
    await MusicPage.currentFile.writeAsBytes((await _loadAsset(name)).buffer.asUint8List());
    final result = await MusicPage.player.play(MusicPage.currentFile.path, isLocal: true);
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
                  icon: Icon(OMIcons.keyboardArrowLeft),
                  onPressed: () => Navigator.pop(context),
                ),
                IconButton(
                  splashColor: Colors.transparent,
                  color: Colors.transparent,
                  icon: Icon(null),
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
                  icon: Icon(OMIcons.loop),
                  onPressed: () {
                    parent.setState(() {
                      MusicPage.loop = !MusicPage.loop;
                    });
                  },
                ),
                IconButton(
                  splashColor: Colors.transparent,
                  color: Colors.white,
                  icon: Icon(OMIcons.save),
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
          icon: Icon(OMIcons.fastRewind),
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
          icon: MusicPage.playing ? Icon(OMIcons.pause) : Icon(OMIcons.playArrow),
          onPressed: () {
            if (MusicPage.playerSet) {
              if (!MusicPage.playing) {
                parent.setState(() {
                  MusicPage.currentlyPlaying = MusicPage.previouslyPlayed;
                  MusicPage.playing = true;
                });
              } else {
                parent.setState(() {
                  MusicPage.previouslyPlayed = MusicPage.currentlyPlaying;
                  MusicPage.currentlyPlaying = '';
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
          icon: Icon(OMIcons.fastForward),
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