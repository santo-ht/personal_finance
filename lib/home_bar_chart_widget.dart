import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

// Define data structure for a bar group
class DataItem {
  int x;
  double y1;
  double y2;
  double y3;
  DataItem(
      {required this.x, required this.y1, required this.y2, required this.y3});
}

class HomeBarChartWidget extends StatelessWidget {
  // Generate dummy data to feed the chart
  final List<DataItem> _myData = List.generate(
      5,
      (index) => DataItem(
            x: index,
            y1: Random().nextInt(5) + Random().nextDouble(),
            y2: Random().nextInt(5) + Random().nextDouble(),
            y3: Random().nextInt(5) + Random().nextDouble(),
          ));

  HomeBarChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BarChart(
        BarChartData(
            borderData: FlBorderData(
                border: const Border(
              top: BorderSide.none,
              right: BorderSide.none,
              left: BorderSide(width: 1),
              bottom: BorderSide(width: 1),
            )),
            groupsSpace: 10,
            barGroups: _myData
                .map((dataItem) => BarChartGroupData(x: dataItem.x, barRods: [
                      BarChartRodData(
                          toY: dataItem.y1, width: 10, color: Colors.amber),
                      /*   BarChartRodData(
                          toY: dataItem.y2, width: 10, color: Colors.red),
                      BarChartRodData(
                          toY: dataItem.y3, width: 10, color: Colors.blue), */
                    ]))
                .toList()),
      ),
    );
  }
}
