import 'package:flutter/material.dart';

import 'package:stress_app/screens/stress_graph.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Graph Page',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Scaffold(
        appBar: AppBar(
            title: Text('Graph Page')
        ),
        body: BodyLayout(context, levels),
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
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Expanded(
            child: StressGraph(levels),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.all(8.0),
            child: FloatingActionButton(
              splashColor: Colors.transparent,
              backgroundColor: Colors.purple,
              child: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(parentContext),
            ),
          ),
        ],
      ),
    );
  }
}


