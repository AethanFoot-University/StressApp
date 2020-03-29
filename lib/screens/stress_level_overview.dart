import 'package:flutter/material.dart';
import 'package:stress_app/data/StressLevel.dart';
import 'package:stress_app/screens/graph_view/graph_analysis_view.dart';
import 'package:stress_app/screens/graph_view/stress_graph.dart';
import 'dart:math';

import 'package:stress_app/style/theme_colours.dart';
import 'package:stress_app/tools/CSVReader.dart';

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

  DataRow generateRow(List<List<StressLevel>> values, int hour, List<StressLevel> allLevels,  BuildContext context){

    List<DataCell> cells = new List<DataCell>();
    cells.add(
      DataCell(
        Container(
          width: 40,
          child: Text(
            "$hour:00",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )
        )
      )
    );

    for(int i = 0; i < values.length; i++) {

      var stress = values[i][hour];

      var stressColor = (stress !=null)?COLOR_SCALE[max(((COLOR_SCALE.length) * (stress.stressLevel/StressLevel.maxLevel.toDouble())).round()-1,0)]
      :Colors.black;
      cells.add(
        DataCell(
          Container(
            height: 15.0,
            decoration: BoxDecoration(color: stressColor),
          ), onTap:(stress !=null)?

            ()=>showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog

            return Column(children: <Widget>[
              RichText(
                  text: TextSpan(
                      style: TextStyle(color: ThemeColours.TEXT_PRIMARY_COLOUR, fontSize: 50),
                      children: <TextSpan>[
                        TextSpan(text: (stress.time.toUtc()).toString())
                      ]
                  )

              ),
              StressGraph(StressLevel.GetByDay(allLevels, stress.time))

            ]);
          },
        )

            :
            //Else Start
            ()=>showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
              title: new Text("We're sorry"),
              content: new Text("No data was recorded for this time"),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                new FlatButton(
                  child: new Text("Close"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        )
            //Else end

        )
      );
    }
    return DataRow(cells: cells);
  }

  Future<DataTable> generateDataTable(BuildContext context, double width) {
    List<DataRow> rows = new List<DataRow>();



   CSVReader("").getStressLevels().then((levels){

        var thisWeek = StressLevel.GetThisWeek(levels, currentDate: new DateTime.utc(2020, 2, 24));

       for(int h =0; h < 24; h++){
         rows.add(generateRow(thisWeek, h, levels,context));
       }
   });



    return Future(() => DataTable(columns: getColumns(), rows: rows, columnSpacing: ((width - 250) / 9) - 1,));
  }

  Widget generateStressTable(BuildContext context, double width) {
    return FutureBuilder(
      future: generateDataTable(context, width),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: Text(
              'Loading...',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        return ListView(
          scrollDirection: Axis.vertical,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Center(
                child: Text(
                  'Stress Overview',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            snapshot.data,
          ],
        );
      },
    );
  }

  final String title;

  @override
  Widget build(BuildContext context) {

    return widgetMode ? widget(context) : page(context);
  }

  Widget page(BuildContext context) {
    return SafeArea(
      child: generateStressTable(context, MediaQuery.of(context).size.width),
    );
  }

  Widget widget(BuildContext context) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        color: Color(0xff424242),

      ),
      child: generateStressTable(context, MediaQuery.of(context).size.width - 32),
    );
  }
}


