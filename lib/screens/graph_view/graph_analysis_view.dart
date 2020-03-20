import 'package:flutter/material.dart';

import 'package:stress_app/screens/graph_view/stress_graph.dart';
import 'package:stress_app/tools/CSVReader.dart';

class GraphAnalysisView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var builder =  FutureBuilder(
      future: CSVReader("").getStressLevels(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          return buildScaffold(context, snapshot.data);
        } else {
          return buildScaffold(context, null);
        }
      },
    );

    return builder;
  }

  Widget buildScaffold(BuildContext context, var levels){
    return Scaffold(
      backgroundColor: Colors.black,
      body: BodyLayout(context, levels),
      floatingActionButton: Container(
        padding: EdgeInsets.only(left: 24.0),
        alignment: Alignment.bottomLeft,
        child: FloatingActionButton(
          splashColor: Colors.transparent,
          backgroundColor: Colors.purple,
          child: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
}

class BodyLayout extends StatelessWidget {
  final BuildContext parentContext;
  final levels;

  BodyLayout(this.parentContext, this.levels);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StressGraph(levels),
    );
  }
}


