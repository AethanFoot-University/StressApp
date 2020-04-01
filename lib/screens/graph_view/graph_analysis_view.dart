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
    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeColours.SECONDARY_BACKGROUND_COLOR,
        body: BodyLayout(currentDate),
      ),
    );
  }
}

class BodyLayout extends StatefulWidget{
  final DateTime currentDate;

  BodyLayout(this.currentDate, {Key key}): super(key: key);

  @override
  _BodyLayoutState createState() => _BodyLayoutState(currentDate);
}

class _BodyLayoutState extends State<BodyLayout>{
  final DateTime currentDate;

  _BodyLayoutState(this.currentDate);

  DatePicker _pickerInst = null;
  List<StressLevel> _levels;

  List<StressLevel> _drawablelevels=null;

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
    return Stack(
      children: <Widget>[
        FutureBuilder(
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
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: ThemeColours.PRIMARY_BUTTON_BACKGROUND,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: IconButton(
                splashColor: Colors.transparent,
                icon: Icon(
                  OMIcons.keyboardArrowLeft,
                  color: ThemeColours.SECONDARY_BUTTON_BACKGROUND,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildGraphView(){
    if(_levels!=null) {
      return Column(
        children: <Widget>[
          SizedBox(height: 30,),
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
    } else {
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


