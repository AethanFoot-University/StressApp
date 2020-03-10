

import 'package:flutter/material.dart';
import 'package:stress_app/data/StressLevel.dart';
import 'package:stress_app/main.dart';
import 'dart:math';

import 'package:stress_app/screens/stress_graph.dart';
import 'package:stress_app/tools/CSVReader.dart';

class GraphAnalysisView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    var builder =  FutureBuilder(
      future: CSVReader("").getStressLevels(),
      builder: (context, snapshot){
        print("futurebuilder");
        print(snapshot.hasData);
        if(snapshot.hasData){
          return buildScaffold(snapshot.data);
        }
        else{
          return buildScaffold(null);
        }
      },
    );

    print("My future is bright!");

    return builder;

  }

  Widget buildScaffold(var levels){
    return Scaffold(
      appBar: AppBar(title: Text('Stress Analysis')),
      body: StressGraph(levels),
    );
  }




}


