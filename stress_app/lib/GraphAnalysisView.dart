import 'package:flutter/material.dart';
import 'dart:math';

import 'StressGraph.dart';
class GraphAnalysisView extends StatelessWidget {
  GraphAnalysisView({Key key, this.title}) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('My Page')),

      body: StressGraph(),
    );

  }
}


