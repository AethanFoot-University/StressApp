import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:core';
import 'package:stress_app/data/StressLevel.dart';
import 'package:stress_app/style/theme_colours.dart';

class StressGraph extends StatelessWidget {
  List<StressLevel> data;
  LineChart _graph;

  StressGraph(List<StressLevel> dataIn){
    data = dataIn;
    _graph = LineChart(mainData(dataIn));
  }

  int _maxPlots = 7;

  Widget drawGraph(){
    if(this.data == null){
      return Column(
          children:[
            Text("There is no data to show"),
            Image(
              image: AssetImage('assets/images/meditate.png'),
            ),
          ],
      );
    } else {
      return Stack(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.70,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(18),
                  ),
                  color: ThemeColours.SECONDARY_BACKGROUND_COLOR),
              child: Padding(
                padding: const EdgeInsets.only(right: 18.0, left: 12.0, top: 24, bottom: 12),
                child: _graph
              ),
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _graph.createState();
    return  drawGraph();

  }

  void updateData(List<StressLevel> newData){
    data = newData;
  }

  List<Color> gradientColors = [
    ThemeColours.TEXT_PRIMARY_COLOUR,
  ];

  String lastValue = " ";
  bool firstVal = true;

  List<FlSpot> getPlotData(){
    List<FlSpot> retList = new List();

    int increment = (data.length/_maxPlots).toInt();

    for(int i=0; i< _maxPlots+1; i++){
      retList.add(FlSpot(i * 1.0, data[i*increment].stressLevel));
    }

    return retList;
  }

  FlTitlesData generateFLTitles(){
    return FlTitlesData(
      show: true,
      bottomTitles: SideTitles(
        showTitles: true,
        reservedSize: 22,
        textStyle:
        TextStyle(color: const Color(0xff68737d), fontWeight: FontWeight.bold, fontSize: 16),
        getTitles: (value) {
          if(value< data.length){
            String newVal = DateFormat('EEEE').format(data[value.toInt()*(data.length/_maxPlots).toInt()].time);
            return newVal.substring(0, 3);
          }
          return '';
        },
        margin: 8,
      ),
      leftTitles: SideTitles(
        showTitles: true,
        textStyle: TextStyle(
          color: const Color(0xff67727d),
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        getTitles: (value) {
          return value.toInt().toString();
        },
        reservedSize: 28,
        margin: 12,
      ),
    );
  }

  LineChartData mainData(List<StressLevel> data) {

    double max =0;
    //data.sort((a,b)=>a.stressLevel.compareTo(b.stressLevel));
    for(StressLevel lvl in data) {
      max = (lvl.stressLevel > max) ? lvl.stressLevel : max;
    }

      return LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          getDrawingHorizontalLine: (value) {
            return const FlLine(
              color: Color(0xff37434d),
              strokeWidth: 1,
            );
          },
          getDrawingVerticalLine: (value) {
            return const FlLine(
              color: Color(0xff37434d),
              strokeWidth: 1,
            );
          },
        ),
        titlesData: generateFLTitles(),
        borderData:
        FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d), width: 1)),
        minX: 0,
        maxX: _maxPlots*1.0,
        minY: 0,
        maxY: max,
        lineBarsData: [
          LineChartBarData(
            spots: getPlotData(),
            isCurved: true,
            colors: gradientColors,
            barWidth: 5,
            isStrokeCapRound: true,
            dotData: const FlDotData(
              show: false,
            ),
            belowBarData: BarAreaData(
              show: true,
              colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
            ),
          ),
        ],
      );
    }
  }



