import 'package:flutter/material.dart';

import 'package:stress_app/screens/stress_level_overview.dart';

class HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Color(0xff101010),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
            ),
            HomeWidget(StressLevelOverview(Color(0xff424242))),
          ],
        ),
      ),
    );
  }
}

class HomeWidget extends StatelessWidget {
  final child;

  HomeWidget(this.child);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Container(
        height: 250,
        child: child,
      ),
    );
  }
}