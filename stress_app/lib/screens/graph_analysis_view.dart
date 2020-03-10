

import 'package:flutter/material.dart';
import 'package:stress_app/data/StressLevel.dart';
import 'package:stress_app/main.dart';
import 'dart:math';

import 'package:stress_app/screens/stress_graph.dart';
import 'package:stress_app/tools/CSVReader.dart';

class GraphAnalysisView extends StatefulWidget {
  final Function(BuildContext) builder;
  final levels;

  GraphAnalysisView(this.levels, {Key key, this.builder}) : super(key: key);

  @override
  _GraphAnalysisViewState createState() => _GraphAnalysisViewState(levels);

  static _GraphAnalysisViewState of (BuildContext context) {
    return context.ancestorStateOfType(const TypeMatcher<_GraphAnalysisViewState>());
  }

}

class _GraphAnalysisViewState extends State<GraphAnalysisView> {


  var _levels = null;

  _GraphAnalysisViewState(this._levels){
    /*print("Adding");
    _levels = MyApp.getLevels();
    print(_levels); */

   /* MyApp.addListener((){
        _levels = MyApp.getLevels();
        print("Updating");
      GraphAnalysisView.of(context).rebuild();
    }); */

    /*var ret = CSVReader("bla ad") .getStressLevels();

    ret.then((levels)=>{
    _levels = levels,
    build(),
    });*/

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    print("hello1 build");
    print(_levels);
    return Scaffold(
      appBar: AppBar(title: Text('Stress Analysis')),
      body: StressGraph(_levels),
    );

  }

  void rebuild() {
    print("rebuild");
    setState(() {

    });
  }


}


