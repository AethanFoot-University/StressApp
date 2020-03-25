import 'package:flutter/widgets.dart';

class StressLevel{
  final DateTime time;
  final double stressLevel;

  StressLevel({@required this.time, @required this.stressLevel});

  static List<DateTime> GetSeparateDays(List<StressLevel> levels){
    List<DateTime> days = new List<DateTime>();
    for(StressLevel level in levels) days.add(level.time);
    days.sort((a,b) => a.compareTo(b));


    List<DateTime> nonRedundant = new List<DateTime>();

    DateTime last = null;

    for(DateTime date in days){
      if(last==null || last.day!=date.day || last.month!=date.month ||last.year!=date.year){
        nonRedundant.add(date);
      }
      last = date;
    }
      return nonRedundant;
  }

  static List<StressLevel> GetByDay(List<StressLevel> levels, DateTime date){
    List<StressLevel> newLevels = new List<StressLevel>();

    for(StressLevel level in levels) if(date.day==level.time.day &&date.month==level.time.month
        &&date.year==level.time.year) {
      newLevels.add(level);
      print(level);
    }

      return newLevels;
    }
  }

