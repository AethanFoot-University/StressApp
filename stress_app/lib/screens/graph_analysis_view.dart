import 'package:flutter/material.dart';
import 'package:stress_app/data/StressLevel.dart';
import 'package:stress_app/main.dart';
import 'dart:math';

import 'package:stress_app/screens/stress_graph.dart';
class GraphAnalysisView extends StatelessWidget {
  GraphAnalysisView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Stress Analysis')),

      body: StressGraph(data: (MyApp.ready)? MyApp.getLevels(): null),
    );

  }
}


