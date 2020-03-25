import 'package:flutter/material.dart';
import 'package:stress_app/screens/graph_view/date_picker.dart';

import 'package:stress_app/screens/graph_view/stress_graph.dart';
import 'package:stress_app/style/theme_colours.dart';
import 'package:stress_app/tools/CSVReader.dart';

class GraphAnalysisView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var builder =  FutureBuilder(
      future: CSVReader("").getStressLevels(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          return buildScaffold(context, snapshot.data);
        } else {
          return buildScaffold(context, null);
        }
      },
    );

    return builder;
  }

  Widget buildScaffold(BuildContext context, var levels){
    return Scaffold(
      backgroundColor: ThemeColours.SECONDARY_BACKGROUND_COLOR,
      body: BodyLayout(context, levels),
      floatingActionButton: Container(
        padding: EdgeInsets.only(left: 24.0),
        alignment: Alignment.bottomLeft,
        child: FloatingActionButton(
          splashColor: Colors.transparent,
          backgroundColor: ThemeColours.PRIMARY_BUTTON_BACKGROUND,
          child: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
}

class BodyLayout extends StatelessWidget {
  final BuildContext parentContext;
  final levels;

  BodyLayout(this.parentContext, this.levels);


  Widget buildText(){
    return RichText(
        text: TextSpan(
              style: TextStyle(color: ThemeColours.TEXT_PRIMARY_COLOUR, fontSize: 50),
              children: <TextSpan>[
                TextSpan(text: "Stress")
              ]
    )

    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[ SizedBox(height: 30,),
                buildText(),
                StressGraph(levels),
                Expanded( child: Container()),
                DatePicker(),
                SizedBox(height: 100)]
    );
  }
}


