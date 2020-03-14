import 'package:flutter/material.dart';
import 'package:stress_app/screens/breathe_page.dart';
import 'package:stress_app/screens/music_page.dart';

class StressReliefPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Color(0xff101010),
      ),
      child: BodyLayout(),
    );
  }
}

class BodyLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RaisedButton(
          child: Text(
            'Breathing Page'
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => BreathePage((MediaQuery.of(context).size.height - 150) ~/ 40)));
          },
        ),
        RaisedButton(
          child: Text(
            'Soothing music'
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MusicPage()));
          },
        ),
      ],
    );
  }
}
