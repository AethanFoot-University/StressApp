import 'dart:io';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';

import 'package:stress_app/data/StressLevel.dart';
class StressGraph extends StatelessWidget {


   List<StressLevel> data;

  StressGraph( this.data);

  List<FlSpot> getPlotData(){
    List<FlSpot> retList = new List();
    int index=0;
    for(StressLevel dataPoint in data){
      index++;
      retList.add(FlSpot( index*1.0, dataPoint.stressLevel));
    }

    return retList;

  }


  Widget drawGraph(){

    print("Drawing graph");
      if(this.data ==null){
        print("Oh no! Data is null");
        return Column(
            children:[Text("There is no data to show"),
            Image.network("https://cdn.dribbble.com/users/1097364/screenshots/6345967/3_2x.png")]
        );
      }
      else{

        return Stack(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.70,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(18),
                    ),
                    color: const Color(0xff232d37)),
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
    // TODO: implement build
    return Scaffold(
      body: drawGraph(),
    );

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
    for(StressLevel lvl in data) max = (lvl.stressLevel>max)? lvl.stressLevel : max;

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
              String newVal = DateFormat('EEEE').format(data[value.toInt()].time);

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
      maxX: data.length*1.0,
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


