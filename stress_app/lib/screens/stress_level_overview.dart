import 'package:flutter/material.dart';
import 'dart:math';

class StressLevelOverview extends StatelessWidget {
  StressLevelOverview({Key key, this.title}) : super(key: key);

  static List<String> DATA_COLUMNS = ["Time", "Monday", "Tuesday",
  "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];

  static List<MaterialColor> COLOR_SCALE = [Colors.red, Colors.orange,
  Colors.green];

  List<DataColumn> getColumns(){
    List<DataColumn> cols = new List<DataColumn>();

    for(String col in DATA_COLUMNS){
      if (col == 'Time') {
        cols.add(
          DataColumn(
            label: Text(
              col
            ),
          )
        );
      } else {
        cols.add(
            DataColumn(
              label: Text(
                  col.substring(0, 3)
              ),
            )
        );
      }
    }
    return cols;
  }

  DataRow generateRow(int len, String time){

    List<DataCell> cells = new List<DataCell>();
    cells.add(
      DataCell(
        Container(
            width: 40,
            child: Text(time)
        )
      )
    );

    for(int i = 0; i < len - 1; i++) {
      var stressColor = COLOR_SCALE[new Random().nextInt(COLOR_SCALE.length)];

      cells.add(
        DataCell(
          Container(
            width: 30, //SET width
            decoration: new BoxDecoration(color: stressColor),
            child: Text("")
          )
        )
      );
    }
    return DataRow(cells: cells);
  }

  Widget generateDataTable() {
    List<DataRow> rows = new List<DataRow>();

    for(int h =0; h < 24; h++){
      rows.add(generateRow(DATA_COLUMNS.length, "$h:00"));
    }

    return DataTable(columns: getColumns(), rows: rows);
  }

  Widget generateStressTable() => LayoutBuilder(
    builder: (context, constraints) => SingleChildScrollView(
      child: Column(
        children: [
          const Text('My Text'),
          Container(
            alignment: Alignment.topLeft,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: constraints.minWidth),
                child: generateDataTable(),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  final String title;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 60,
          ),
          Expanded(
            child: generateStressTable(),
          )
        ],
      ),
    );
  }
}


