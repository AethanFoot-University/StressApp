import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:stress_app/data/StressLevel.dart';

class CSVReader {
  String _currentPath;

  CSVReader(@required this._currentPath);

  Future<List<StressLevel>> getStressLevels() {
    return   Future(() async {
      List<StressLevel> testStress = new List();
      List<List<String>> rows = await readCSV('');

      for (List<String> row in rows) {
        testStress.add(
          StressLevel(time: DateTime.parse(row[6]), stressLevel: double.parse(row[7]) / 10)
        );
      }
      return testStress;
    });
  }

  static Future<List<List<String>>> readCSV(String dir) async {
    List<String> lines = new List();
    List<List<String>> rows = new List();

    String wholeLine = await loadFile();
    lines = wholeLine.split('\n');

    for (int j = 2; j < lines.length - 1; j++) {
      List<String> row = lines[j].split(',');
      rows.add(row);
    }
    return rows;
  }

  static Future<String> loadFile() async {
    return await rootBundle.loadString('assets/com.samsung.shealth.stress.202003111542.csv');
  }
}