import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../domain/models/resource.dart';

class ResourceChartWidget extends StatelessWidget {
  final List<Resource>? mapResources;
  final List<String> dayData;
  ResourceChartWidget({
    Key? key,
    required this.mapResources,
    required this.dayData,
  }) : super(key: key);
  List<Color> gradientColors = [
    Colors.orange,
    Colors.orangeAccent,
  ];
  double maxData = 0.0;
  @override
  Widget build(BuildContext context) {
    print(mapResources);
    return SafeArea(
      top: false,
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: Card(
          color: Colors.blueGrey.withOpacity(0.8),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 5,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  mapResources![0].key!,
                  style: const TextStyle(
                    color: Colors.orangeAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              AspectRatio(
                aspectRatio: 1.70,
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 16,
                    left: 12,
                    top: 12,
                    bottom: 12,
                  ),
                  child: LineChart(
                    mainData(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.black,
            strokeWidth: 1.0,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Colors.black,
            strokeWidth: 1.0,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1.0,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1.0,
            getTitlesWidget: leftTitleWidgets,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0.0,
      // maxX: (dayData.length - 1).toDouble(),
      minY: 0.0,
      // maxY: maxData + 0.1,
      lineBarsData: [
        LineChartBarData(
          spots: makeSpotData(),
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: dayData.length.toDouble(),
          isStrokeCapRound: true,
          dotData: const FlDotData(show: true),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 9,
      color: Colors.white,
    );
    Widget text;
    text = Text(dayData[value.toInt()], style: style);
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 9,
      color: Colors.white,
    );
    String text = value.toString() + '\$';
    return Text(text, style: style, textAlign: TextAlign.left);
  }

  List<FlSpot> makeSpotData() {
    List<FlSpot> data = [];
    for (double i = 0; i < mapResources!.length; i++) {
      double amountData = double.parse(
          double.parse(mapResources![i.toInt()].amount!).toStringAsFixed(10));
      data.add(FlSpot(i, amountData));
      if (maxData < amountData) {
        maxData = amountData;
      }
    }
    print(maxData);
    return data;
  }
}
