import 'package:flutter/material.dart';
import 'package:stress_app/data/StressLevel.dart';

import 'package:stress_app/screens/graph_view/events_view.dart';
import 'package:stress_app/screens/graph_view/graph_analysis_view.dart';

import 'package:stress_app/screens/graph_view/stress_graph.dart';
import 'dart:math';

import 'package:stress_app/style/theme_colours.dart';
import 'package:stress_app/tools/CSVReader.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeEmbed extends StatelessWidget {
  YoutubeEmbed({Key key, this.title}) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {

    return widget(context);
  }

  Widget widget(BuildContext context) {
    return Column(children: <Widget>[

      SizedBox(height:30,),


      Container(
    height: 215,
      decoration: BoxDecoration(
        color: ThemeColours.PRIMARY_BACKGROUND_COLOR,

      ),
      child: generateEmbed(context, MediaQuery.of(context).size.width - 32),
    ),

      Center(child: Text(
        'Getting Started',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      )),
      SizedBox(height: 120,)

    ]);

  }

  generateEmbed(BuildContext context, double width) {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: 'JslvBcIVtDg',
      flags: YoutubePlayerFlags(
        controlsVisibleAtStart: false,
        autoPlay: true,
        loop: true,
        enableCaption: false,
      ),
    );

    return YoutubePlayer(
      width: width,
      controller: _controller,
      showVideoProgressIndicator: false,
    );

  }
}


