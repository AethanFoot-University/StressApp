import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:core';
import 'package:stress_app/data/StressLevel.dart';
import 'package:stress_app/style/theme_colours.dart';

class DatePicker extends StatelessWidget {

  DatePicker();



  Widget drawMainScroll(){
   return Column(
     mainAxisAlignment: MainAxisAlignment.center,
     children: <Widget>[
       DatePickerTimeline(
         DateTime.now(),
         onDateChange: (date) {
           // New date selected
           print(date.day.toString());
         },
         selectionColor: ThemeColours.SECONDARY_BACKGROUND_COLOR,
         dayTextStyle: TextStyle(color: Colors.white),
         dateTextStyle: TextStyle(color: Colors.white),
         monthTextStyle: TextStyle(color: Colors.white),
       ),
     ],
   );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height:80,
     child: drawMainScroll(),
      color: ThemeColours.PRIMARY_BACKGROUND_COLOR,
    );
  }

}


