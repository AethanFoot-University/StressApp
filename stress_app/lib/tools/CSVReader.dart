import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:stress_app/data/StressLevel.dart';

class CSVReader {

  String _currentPath;

  CSVReader( @required this._currentPath);

  Future<List<StressLevel>> getStressLevels() {




    return   Future(() {
      List<StressLevel> testStress = [
        StressLevel(time: DateTime.now(), stressLevel: 5.0),
        StressLevel(time: DateTime.now(), stressLevel: 7.0),
        StressLevel(time: DateTime.now(), stressLevel: 8.0),
        StressLevel(time: DateTime.now(), stressLevel: 8.0),
        StressLevel(time: DateTime.now(), stressLevel: 5.0),
        StressLevel(time: DateTime.now(), stressLevel: 2.0),
      ];



      return testStress;
    });
  }

  static List<List<String>> readCSV(String dir) {
    List<String> lines = new List();
    List<List<String>> rows = new List();

    File file = new File(dir);

    Stream<List> inputStream = file.openRead();

    inputStream
        .transform(utf8.decoder)       // Decode bytes to UTF-8.
        .transform(new LineSplitter()) // Convert stream to individual lines.
        .listen((String line) {        // Process results.
      lines.add(line);
    },
        onDone: () {
          print('File is now closed.');
          int len = lines[1].split(',').length;
          for (int i = 0; i < len; i++) {
            List<String> row = new List();
            for (int j = 2; j < lines.length; j++) {
              List<String> val = lines[j].split(',');
              row.add(val[i]);
            }
            rows.add(row);
          }
          print(rows[1]);
        },
        onError: (e) {print(e.toString());});
    return rows;
  }
}