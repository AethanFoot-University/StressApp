import 'package:flutter/material.dart';

import 'package:stress_app/screens/graph_analysis_view.dart';
import 'package:stress_app/screens/stress_level_overview.dart';

import 'package:stress_app/screens/homepage.dart';
import 'package:stress_app/tools/CSVReader.dart';

import 'data/StressLevel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  static  List<StressLevel> _levels = null;

  static bool _ready = false;

  static bool get ready => _ready;

  static getLevels(){
    return [].addAll(_levels);
  }


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    var ret = CSVReader("bla ad").getStressLevels();


    ret.then((levels)=>{
      _levels = levels,
      _ready = (_levels ==null)
    });

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }




}


