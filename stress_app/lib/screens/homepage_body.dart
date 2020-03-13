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
          color: Color(0xffffffff),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 60,
            ),
            HomeWidget(StressLevelOverview(Colors.purple)),
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
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 4,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: child,
      ),
    );
  }
}