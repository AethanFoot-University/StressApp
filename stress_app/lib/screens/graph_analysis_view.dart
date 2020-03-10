import 'package:flutter/material.dart';
import 'package:stress_app/data/StressLevel.dart';
import 'dart:math';

import 'package:stress_app/screens/stress_graph.dart';
class GraphAnalysisView extends StatelessWidget {
  GraphAnalysisView({Key key, this.title}) : super(key: key);

  final String title;

  List<StressLevel> testStress = [
    StressLevel(time: DateTime.now(), stressLevel: 5.0),
    StressLevel(time: DateTime.now(), stressLevel: 7.0),
    StressLevel(time: DateTime.now(), stressLevel: 8.0),
    StressLevel(time: DateTime.now(), stressLevel: 8.0),
    StressLevel(time: DateTime.now(), stressLevel: 5.0),
    StressLevel(time: DateTime.now(), stressLevel: 2.0),
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Stress Analysis')),

      body: StressGraph(data: testStress),
    );

  }
}


