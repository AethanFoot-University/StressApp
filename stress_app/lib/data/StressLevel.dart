


import 'package:flutter/widgets.dart';

class StressLevel<t extends int,double,float>{

  final DateTime time;
  final t stressLevel;

  StressLevel({@required this.time, @required this.stressLevel});
}