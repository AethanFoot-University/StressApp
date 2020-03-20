import 'package:flutter/material.dart';

import 'package:stress_app/screens/stress_level_overview.dart';
import 'package:stress_app/screens/stress_relief/music_page.dart';
import 'package:stress_app/style/theme_colours.dart';

import '../../tools/CSVReader.dart';
import '../graph_view/stress_graph.dart';
import '../graph_view/stress_graph.dart';

class HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: ThemeColours.SECONDARY_BACKGROUND_COLOR,
      ),
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
          ),
          _HomeWidget(StressLevelOverview(true)),
          _HomeWidget(MusicPage(true)),
          _HomeWidget(FutureBuilder(
            future: CSVReader("").getStressLevels(),
            builder: (context, snapshot){
                return StressGraph(snapshot.data);
            },
          ))
        ],
      ),
    );
  }
}

class _HomeWidget extends StatelessWidget {
  final _child;

  _HomeWidget(this._child);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Container(
        height: 250,
        child: _child,
      ),
    );
  }
}