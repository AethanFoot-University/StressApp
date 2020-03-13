import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class BreathePage extends StatefulWidget {
  final int num;

  BreathePage(this.num, {Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BreathePageState createState() => _BreathePageState(num);
}

class _BreathePageState extends State<BreathePage> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  Tween<double> tween;
  var colorMap = new Map();
  final int num;

  _BreathePageState(this.num);

  void generateColorMap() {
    double amount = num / 9;

    for (var j = 1; j <= 9; j++) {
      for (var i = 0; i < num; i++) {
        if (i <= amount * j && colorMap[i] == null) {
          colorMap[i] = Colors.teal[j * 100];
        } else {
          continue;
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    generateColorMap();
    controller = AnimationController(duration: const Duration(seconds: 3), vsync: this);
    tween = Tween<double>(begin: 0, end: num.toDouble() + (num / 10));
    animation = tween.animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    if (animation.value == num.toDouble() + (num / 10)) {
      tween.begin = num.toDouble();
      tween.end = -(num / 10);
      controller.reset();
      controller.forward();
    } else if (animation.value == -(num / 10)) {
      tween.begin = 0;
      tween.end = num.toDouble() + (num / 10);
      controller.reset();
      controller.forward();
    }
    return Column(
      children: <Widget>[
        SizedBox(
          height: 60,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: breathe(context),
        ),
      ]
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  List<Widget> breathe(BuildContext context) {
    List<Widget> containers = new List();
    double maxWidth = MediaQuery.of(context).size.width - 32;
    //double minWidth = maxWidth / 3;
    //double actualMin;

    for (var i = 0; i < num; i++) {
      if (maxWidth * (cos((pi / num) * i)).abs() < 1) {
        //if (actualMin == null) actualMin = maxWidth * (cos((pi / num) * i)).abs();
        containers.add(createContainer(2 * (maxWidth * (cos((pi / num) * (i + 1))).abs()) / 3, 24, i));
      } else {
        containers.add(createContainer(maxWidth * (cos((pi / num) * i)).abs(), 24, i));
      }
      containers.add(SizedBox(
        height: 15,
      ));
    }

    return containers;
  }

  Widget createContainer(double width, double height, int i) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: animation.value > i ? colorMap[i] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorMap[i],
          width: 2,
        ),
      ),
    );
  }
}