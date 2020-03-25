
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stress_app/components/DatePicker/date_picker_timeline.dart';
import 'dart:core';
import 'package:stress_app/data/StressLevel.dart';
import 'package:stress_app/style/theme_colours.dart';

class DatePicker extends StatelessWidget {
  List<DateTime> dates;
  Function(DateTime, DatePickerTimeline) dateChanged;

  DatePicker({this.dates, this.dateChanged});



  Widget drawMainScroll(){
    var date =  DateTime.now().add(Duration(days: -10));
    print(date.toIso8601String());
    date.add(Duration(days: -10));
    print(date.toIso8601String());

   return Column(
     mainAxisAlignment: MainAxisAlignment.center,
     children: <Widget>[
       DatePickerTimeline(
         onDateChange: dateChanged,
         dates: dates,
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


