import 'package:flutter/material.dart';

import 'package:stress_app/data/StressLevel.dart';
import 'package:stress_app/screens/graph_view/date_picker.dart';

import 'package:outline_material_icons/outline_material_icons.dart';


import 'package:stress_app/screens/graph_view/stress_graph.dart';
import 'package:stress_app/style/theme_colours.dart';
import 'package:stress_app/tools/CSVReader.dart';

class GraphAnalysisView extends StatelessWidget {

  DateTime currentDate;
  GraphAnalysisView({this.currentDate=null}){
    currentDate = (currentDate==null)? DateTime.now() : currentDate;
  }

  @override
  Widget build(BuildContext context) {


    return buildScaffold(context);
  }

  Widget buildScaffold(BuildContext context){

    return Scaffold(
      backgroundColor: ThemeColours.SECONDARY_BACKGROUND_COLOR,
      body: BodyLayout(context, currentDate),
      floatingActionButton: Container(
        padding: EdgeInsets.only(left: 24.0),
        alignment: Alignment.bottomLeft,
        child: FloatingActionButton(
          splashColor: Colors.transparent,

          backgroundColor: ThemeColours.PRIMARY_BUTTON_BACKGROUND,
          child: Icon(OMIcons.keyboardArrowLeft),

          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
}

class BodyLayout extends StatefulWidget{



  final BuildContext parentContext;
  final DateTime currentDate;

  BodyLayout(this.parentContext, this.currentDate, {Key key}): super(key: key);


  @override
  _BodyLayoutState createState() => _BodyLayoutState(parentContext, currentDate);
}

class _BodyLayoutState extends State<BodyLayout>{


      final BuildContext context;
      final DateTime currentDate;

      _BodyLayoutState(this.context, this.currentDate);

      DatePicker _pickerInst = null;
      List<StressLevel> _levels;

      List<StressLevel> _drawablelevels=null;
      
      @override
      void initState() {
        super.initState();
      }
        Widget buildText(){
          return RichText(
              text: TextSpan(
                  style: TextStyle(color: ThemeColours.TEXT_PRIMARY_COLOUR, fontSize: 50),
                  children: <TextSpan>[
                    TextSpan(text: ("Stress Breakdown").toString())
                  ]
              )

          );
        }
      @override
      Widget build(BuildContext context) {
        return FutureBuilder(
          future: CSVReader("").getStressLevels(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              _levels = snapshot.data;

              var day = StressLevel.GetByDay(_levels, currentDate);
              _drawablelevels = (day.length>0)? day : _drawablelevels;

              return buildGraphView();
            } else {
              return buildGraphView();
            }
          },
        );
      }

      Widget buildGraphView(){
        if(_levels!=null) {
          return Column(
              children: <Widget>[ SizedBox(height: 30,),
              buildText(),
              StressGraph((_drawablelevels==null)?_levels:_drawablelevels),

              Expanded(child: Container()),
              (_pickerInst = (_pickerInst==null)? DatePicker(

                dates: StressLevel.GetSeparateDays(_levels),
                dateChanged: (date, timeline) {

                  setState(() {
                    var day =  StressLevel.GetByDay(_levels, date);
                    this._drawablelevels = (day.length>0)?day: null;

                  });
                  print(date);
                },
              ): _pickerInst),

              SizedBox(height: 100)
              ]
          );
        }
        else{
          return Column(
              children: <Widget>[ SizedBox(height: 30,),
              buildText(),
              Expanded(child: Container()),
              SizedBox(height: 100)
              ]
          );
        }
      }


}


