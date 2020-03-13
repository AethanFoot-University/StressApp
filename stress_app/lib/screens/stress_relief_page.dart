import 'package:flutter/material.dart';
import 'package:stress_app/screens/breathe_page.dart';

class StressReliefPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Color(0xffffffff),
      ),
      child: BreathePage((MediaQuery.of(context).size.height - 100) ~/ 40),
    );
  }
}