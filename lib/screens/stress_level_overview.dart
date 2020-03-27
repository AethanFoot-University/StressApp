import 'package:flutter/material.dart';
import 'dart:math';

class StressLevelOverview extends StatelessWidget {
  StressLevelOverview(this.widgetMode, {Key key, this.title}) : super(key: key);

  final widgetMode;

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
              col,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        );
      } else {
        cols.add(
            DataColumn(
              label: Text(
                col.substring(0, 1),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
        );
      }
    }
    return cols;
  }

  DataRow generateRow(int len, String time, BuildContext context){

    List<DataCell> cells = new List<DataCell>();
    cells.add(
      DataCell(
        Container(
          width: 40,
          child: Text(
            time,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )
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

  Widget generateDataTable(BuildContext context, double width) {
    List<DataRow> rows = new List<DataRow>();

    for(int h =0; h < 24; h++){
      rows.add(generateRow(DATA_COLUMNS.length, "$h:00", context));
    }

    return DataTable(columns: getColumns(), rows: rows, columnSpacing: ((width - 250) / 9) - 1,);
  }

  Widget generateStressTable(BuildContext context, double width) => LayoutBuilder(
    builder: (context, constraints) => SingleChildScrollView(
      child: Column(
        children: [
          const Text(
            'My Text',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: constraints.minWidth, maxWidth: width),
                child: generateDataTable(context, width),
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
    return widgetMode ?
    widgetVersion(context) :
    Container(
      decoration: BoxDecoration(
        color: Color(0xff101010),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 16,
          ),
          Expanded(
            child: generateStressTable(context, MediaQuery.of(context).size.width),
          ),
        ],
      ),
    );
  }

  Widget widgetVersion(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff424242),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 16,
            ),
            Expanded(
              child: generateStressTable(context, MediaQuery.of(context).size.width - 32),
            ),
          ],
        ),
      ),
    );
  }
}


