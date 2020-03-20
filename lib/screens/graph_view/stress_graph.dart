import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:core';
import 'package:stress_app/data/StressLevel.dart';
import 'package:stress_app/style/theme_colours.dart';

class StressGraph extends StatelessWidget {
  List<StressLevel> data;

  StressGraph(this.data);

  int _maxPlots = 7;

  List<FlSpot> getPlotData(){
    List<FlSpot> retList = new List();

    int increment = (data.length/_maxPlots).toInt();

    for(int i=0; i< _maxPlots+1; i++){
      print(i);
      retList.add(FlSpot(i * 1.0, data[i*increment].stressLevel));
    }

    return retList;
  }

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
                  color: ThemeColours.TEXT_PRIMARY_COLOUR),
              child: Padding(
                padding: const EdgeInsets.only(right: 18.0, left: 12.0, top: 24, bottom: 12),
                child: LineChart(
                  mainData(),
                ),
              ),
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return  drawGraph();

  }

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  String lastValue = " ";
  bool firstVal = true;

  LineChartData mainData() {
    double max =0;
    //data.sort((a,b)=>a.stressLevel.compareTo(b.stressLevel));
    for(StressLevel lvl in data) max = (lvl.stressLevel > max) ? lvl.stressLevel : max;

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
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle:
          TextStyle(color: const Color(0xff68737d), fontWeight: FontWeight.bold, fontSize: 16),
          getTitles: (value) {
            if(value< data.length){
              print(value);
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
      ),
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


