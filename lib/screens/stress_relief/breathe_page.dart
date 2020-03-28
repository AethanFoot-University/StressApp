import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class BreathePage extends StatefulWidget {
  final int num;

  BreathePage(this.num, {Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BreathePageState createState() => _BreathePageState(num);
}

class _BreathePageState extends State<BreathePage> with TickerProviderStateMixin {
  Animation<double> _breatheAnimation;
  AnimationController _breatheController;
  Tween<double> _breatheTween;

  Animation<double> _textAnimation;
  AnimationController _textController;
  Tween<double> _textTween;

  List<String> _lines = [
    'Make sure your in a comfortable position',
    'Relax your shoulders',
    'Breathe in through your nose and out through your mouth with the animation',
    'Make sure your stomach is moving out while your chest remains still'
  ];
  int _pos = 0;

  var _colorMap = new Map();
  final int _num;

  _BreathePageState(this._num);

  @override
  void initState() {
    super.initState();
    _generateColorMap();
    _setupBreathe();
    _setupText();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Color(0xff101010),
          ),
          child: Column(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _breathe(context),
                ),
                Center(
                  child: Text(
                    _lines[_pos],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(_textAnimation.value),
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: IconButton(
                      splashColor: Colors.transparent,
                      icon: Icon(
                        OMIcons.keyboardArrowLeft,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _breatheController.dispose();
    _textController.dispose();
    super.dispose();
  }

  void _generateColorMap() {
    double amount = _num / 9;
    for (var j = 1; j <= 9; j++) {
      for (var i = 0; i < _num; i++) {
        if (i <= amount * j && _colorMap[i] == null) {
          _colorMap[i] = Colors.teal[j * 100];
        } else {
          continue;
        }
      }
    }
  }

  void _setupBreathe() {
    _breatheController = AnimationController(duration: const Duration(seconds: 3), vsync: this);
    _breatheController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _breatheController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _breatheController.forward();
      }
    });
    _breatheTween = Tween<double>(begin: -(_num / 10), end: _num.toDouble() + (_num / 10));
    _breatheAnimation = _breatheTween.animate(_breatheController)
      ..addListener(() {
        setState(() {});
      });
    _breatheController.forward();
  }

  void _setupText() {
    _textController = AnimationController(duration: const Duration(seconds: 3), vsync: this);
    _textController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _textController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        setState(() {
          _pos < _lines.length - 1 ? _pos++ : _pos = 0;
        });
        _textController.forward();
      }
    });
    _textTween = Tween<double>(begin: 0, end: 1);
    _textAnimation = _textTween.animate(_textController)
      ..addListener(() {
        setState(() {});
      });
    _textController.forward();
  }

  List<Widget> _breathe(BuildContext context) {
    List<Widget> containers = new List();
    double maxWidth = MediaQuery.of(context).size.width - 32;
    //double minWidth = maxWidth / 3;
    //double actualMin;

    for (var i = 0; i < _num; i++) {
      if (maxWidth * (cos((pi / _num) * i)).abs() < 1) {
        //if (actualMin == null) actualMin = maxWidth * (cos((pi / num) * i)).abs();
        containers.add(_createContainer(2 * (maxWidth * (cos((pi / _num) * (i + 1))).abs()) / 3, 24, i));
      } else {
        containers.add(_createContainer(maxWidth * (cos((pi / _num) * i)).abs(), 24, i));
      }
      containers.add(SizedBox(
        height: 15,
      ));
    }

    return containers;
  }

  Widget _createContainer(double width, double height, int i) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: _breatheAnimation.value > i ? _colorMap[i] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _colorMap[i],
          width: 2,
        ),
      ),
    );
  }
}