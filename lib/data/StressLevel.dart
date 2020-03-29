import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StressLevel{
  static const int maxLevel = 10;

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

    static List<List<double>> GetThisWeek(List<StressLevel> levels, {DateTime currentDate=null}){

      currentDate = (currentDate==null)? DateTime.now() : currentDate;

      print(currentDate.weekday);
      int difference = currentDate.weekday-DateTime.monday;

      DateTime lowerBound = currentDate.subtract(new Duration(days: difference));
      lowerBound = new DateTime.utc(lowerBound.year, lowerBound.month, lowerBound.day);

      DateTime upperBound = lowerBound.add(new Duration(days: 6));

      List<List<double>> week  = List.generate(7, (i) => List(24), growable: false);
      print(lowerBound);

      DateTime lastDate = null;
      double currentCount =0, currentSum =0;

      for(StressLevel level in levels){

        if(lowerBound.compareTo(level.time)<=0 &&upperBound.compareTo(level.time)>=0){
          if(lastDate==null){
            lastDate = level.time;
          } else if(lastDate.day!=level.time.day || lastDate.hour!=level.time.hour){
              week[lastDate.weekday][lastDate.hour] = currentSum/currentCount;

              currentCount=0;
              currentSum =0;
              lastDate = level.time;
          }

            currentCount++;
            currentSum += level.stressLevel;

        }
      }
      return week;
    }
  }

