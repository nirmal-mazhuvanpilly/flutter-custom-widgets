import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:rainbow_color/rainbow_color.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  List<Color> gradientColors = [
    Colors.red,
    Colors.deepOrange,
    Colors.orangeAccent,
    Colors.yellowAccent,
  ];

  final rainBowColorTween = RainbowColorTween([
    Colors.red,
    Colors.deepOrange,
    Colors.orangeAccent,
    Colors.yellowAccent,
  ]);

  bool showAvg = false;

  List<FlSpot> getChart() {
    final random = Random();

    return [
      FlSpot(0, random.nextDouble() * 5.8),
      FlSpot(1, random.nextDouble() * 5.8),
      FlSpot(2, random.nextDouble() * 5.8),
      FlSpot(3, random.nextDouble() * 5.8),
      FlSpot(4, random.nextDouble() * 5.8),
      FlSpot(5, random.nextDouble() * 5.8),
      FlSpot(6, random.nextDouble() * 5.8),
      FlSpot(7, random.nextDouble() * 5.8),
      FlSpot(8, random.nextDouble() * 5.8),
      FlSpot(9, random.nextDouble() * 5.8),
      FlSpot(10, random.nextDouble() * 5.8),
      FlSpot(11, random.nextDouble() * 5.8),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AspectRatio(
                  aspectRatio: 1.70,
                  child: LineChart(
                    showAvg ? avgData() : mainData(),
                    swapAnimationDuration: const Duration(milliseconds: 250),
                    swapAnimationCurve: Curves.linear,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    showAvg = !showAvg;
                  });
                },
                child: Text(
                  'Average',
                  style: TextStyle(
                    fontSize: 12,
                    color:
                        showAvg ? Colors.white.withOpacity(0.5) : Colors.white,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {});
                },
                child: Text(
                  'Change',
                  style: TextStyle(
                    fontSize: 12,
                    color:
                        showAvg ? Colors.white.withOpacity(0.5) : Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 8,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('JAN', style: style);
        break;
      case 1:
        text = const Text('FEB', style: style);
        break;
      case 2:
        text = const Text('MAR', style: style);
        break;
      case 3:
        text = const Text('APR', style: style);
        break;
      case 4:
        text = const Text('MAY', style: style);
        break;
      case 5:
        text = const Text('JUN', style: style);
        break;
      case 6:
        text = const Text('JUL', style: style);
        break;

      case 7:
        text = const Text('AUG', style: style);
        break;
      case 8:
        text = const Text('SEP', style: style);
        break;
      case 9:
        text = const Text('OCT', style: style);
        break;
      case 10:
        text = const Text('NOV', style: style);
        break;
      case 11:
        text = const Text('DEC', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      angle: 312 * (pi / 180),
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 8,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '10K';
        break;
      case 2:
        text = '20K';
        break;
      case 3:
        text = '30K';
        break;
      case 4:
        text = '40K';
        break;
      case 5:
        text = '50K';
        break;
      case 6:
        text = '60K';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.red.withOpacity(.10),
        ),
        getTouchedSpotIndicator: (barData, spotIndexes) {
          return spotIndexes.map(
            (int index) {
              final line = FlLine(
                  color: Colors.cyanAccent, strokeWidth: 1, dashArray: [2, 4]);
              return TouchedSpotIndicatorData(
                line,
                FlDotData(
                  show: true,
                  getDotPainter: (_, __, ___, ____) {
                    return FlDotCirclePainter(
                        color: Colors.lightGreenAccent, radius: 7);
                  },
                ),
              );
            },
          ).toList();
        },
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.transparent,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(color: Colors.transparent);
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 0,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 0,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: getChart(),
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          barWidth: 1.5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
            getDotPainter: (flSpot, _, __, ___) {
              final color = 1 - (flSpot.y / 5.8);
              return FlDotCirclePainter(
                  color: rainBowColorTween.lerp(color),
                  strokeColor: Colors.cyanAccent.withOpacity(.10),
                  strokeWidth: 1);
            },
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 20,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
            spots: const [
              FlSpot(0, 3.44),
              FlSpot(2.6, 3.44),
              FlSpot(4.9, 3.44),
              FlSpot(6.8, 3.44),
              FlSpot(8, 3.44),
              FlSpot(9.5, 3.44),
              FlSpot(11, 3.44),
            ],
            isCurved: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!,
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!,
              ],
            ),
            barWidth: 1.5,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: false,
            ),
            belowBarData: BarAreaData(
              show: true,
              cutOffY: 0,
              applyCutOffY: true,
              gradient: LinearGradient(
                colors: gradientColors
                    .map((color) => color.withOpacity(0.5))
                    .toList(),
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            aboveBarData: BarAreaData(
              show: true,
              color: Colors.cyanAccent.withOpacity(.10),
            )),
      ],
    );
  }
}
