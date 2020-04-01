import 'dart:core';

import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stress_app/style/theme_colours.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return new ListDisplay();
  }
}
class EventsView extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return ListDisplay();
  }
}
class ListDisplay extends StatelessWidget {
  @override
  Widget build (BuildContext ctxt) {
    return new Container(
      height: 200,
        color: Colors.black,
        child:   builder()
    );
  }

  static List<String> events = ["7:30 - Morning Run", "9:00 - ML Coursework", "12:00 - Lunch", "14:00 - Group Meeting","17:00 - HCI Revision", ];

Widget builder() {

    return Scaffold(body: Center(child: ListView.builder(
      shrinkWrap: true,
      itemCount: events.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Text(events[index], textAlign: TextAlign.center,  style: TextStyle(color: ThemeColours.TEXT_SECONDARY_COLOUR, fontSize: 30),);
      },
    )),
    backgroundColor: Colors.transparent,);
  }



}