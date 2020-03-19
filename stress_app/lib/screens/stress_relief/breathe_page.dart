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

class _BreathePageState extends State<BreathePage> with TickerProviderStateMixin {
  Animation<double> breatheAnimation;
  AnimationController breatheController;
  Tween<double> breatheTween;

  Animation<double> textAnimation;
  AnimationController textController;
  Tween<double> textTween;

  List<String> lines = [
    'Make sure your in a comfortable position',
    'Relax your shoulders',
    'Breathe in through your nose and out through your mouth with the animation',
    'Make sure your stomach is moving out while your chest remains still'
  ];
  int pos = 0;

  var colorMap = new Map();
  final int num;

  _BreathePageState(this.num);

  @override
  void initState() {
    super.initState();
    generateColorMap();
    setupBreathe();
    setupText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Color(0xff101010),
        ),
        child: Column(
            children: <Widget>[
              SizedBox(
                height: 60,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: breathe(context),
              ),
              Center(
                child: Text(
                  lines[pos],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(textAnimation.value),
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
            ]
        ),
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.only(left: 24.0),
        alignment: Alignment.bottomLeft,
        child: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }

  @override
  void dispose() {
    breatheController.dispose();
    textController.dispose();
    super.dispose();
  }

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

  void setupBreathe() {
    breatheController = AnimationController(duration: const Duration(seconds: 3), vsync: this);
    breatheController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        breatheController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        breatheController.forward();
      }
    });
    breatheTween = Tween<double>(begin: -(num / 10), end: num.toDouble() + (num / 10));
    breatheAnimation = breatheTween.animate(breatheController)
      ..addListener(() {
        setState(() {});
      });
    breatheController.forward();
  }

  void setupText() {
    textController = AnimationController(duration: const Duration(seconds: 3), vsync: this);
    textController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        textController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        setState(() {
          pos < lines.length - 1 ? pos++ : pos = 0;
        });
        textController.forward();
      }
    });
    textTween = Tween<double>(begin: 0, end: 1);
    textAnimation = textTween.animate(textController)
      ..addListener(() {
        setState(() {});
      });
    textController.forward();
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
        color: breatheAnimation.value > i ? colorMap[i] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorMap[i],
          width: 2,
        ),
      ),
    );
  }
}