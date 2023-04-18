import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:instock_mobile/src/theme/common_theme.dart';

//Heavily modified from example given in documentation
class ShopPerformanceGraph extends StatefulWidget {
  ShopPerformanceGraph(
      {super.key, required this.salesByMonth, required this.deductionsByMonth});

  final CommonTheme theme = CommonTheme();
  var salesByMonth;
  var deductionsByMonth;

  @override
  State<StatefulWidget> createState() => ShopPerformanceGraphState();
}

class ShopPerformanceGraphState extends State<ShopPerformanceGraph> {
  final double width = 7;
  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;
  List<String>? _months = [];
  int maxYAxis = 10;

  int touchedGroupIndex = -1;

  void extractGraphPoints() {
    int x = 0;
    List<BarChartGroupData> graphPoints = [];
    for (var year in widget.salesByMonth.keys) {
      Map<String, dynamic> salesYearDict = widget.salesByMonth[year];
      Map<String, dynamic> deductionsYearDict = Map<String, dynamic>();
      // add deductions if they exist
      if (widget.deductionsByMonth[year] != null) {
        deductionsYearDict = widget.deductionsByMonth[year];
      }

      for (var month in salesYearDict.keys) {
        int? monthlySales = salesYearDict[month];
        // set deduction to 0 if there are none
        int? monthlyDeductions = deductionsYearDict[month] ?? 0;

        int maxInt = max(monthlySales!, monthlyDeductions!);
        String monthPlusYear = '$month $year';

        // set max Y axis based on highest value
        if (maxInt > maxYAxis) {
          maxYAxis = (maxInt / 100).ceil() * 100;
        }
        BarChartGroupData barGroup = makeGroupData(
            x, monthlySales.toDouble(), monthlyDeductions.toDouble());

        _months!.add(monthPlusYear);
        graphPoints.add(barGroup);
        x++;
      }
    }

    // only add 6 most recent months
    _months = _months!.reversed
        .toList()
        .sublist(max(0, graphPoints.length - 6), graphPoints.length);
    graphPoints = graphPoints.reversed
        .toList()
        .sublist(max(0, graphPoints.length - 6), graphPoints.length);

    rawBarGroups = graphPoints;
    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    extractGraphPoints();
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(
              height: 38,
            ),
            Expanded(
              child: BarChart(
                BarChartData(
                  maxY: maxYAxis.toDouble(),
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      tooltipBgColor: widget.theme.themeData.primaryColorDark,
                      getTooltipItem: (a, b, c, d) => null,
                    ),
                    touchCallback: (FlTouchEvent event, response) {
                      if (response == null || response.spot == null) {
                        setState(() {
                          touchedGroupIndex = -1;
                          showingBarGroups = List.of(rawBarGroups);
                        });
                        return;
                      }

                      touchedGroupIndex = response.spot!.touchedBarGroupIndex;

                      setState(() {
                        if (!event.isInterestedForInteractions) {
                          touchedGroupIndex = -1;
                          showingBarGroups = List.of(rawBarGroups);
                          return;
                        }
                        showingBarGroups = List.of(rawBarGroups);
                        if (touchedGroupIndex != -1) {
                          var sum = 0.0;
                          for (final rod
                              in showingBarGroups[touchedGroupIndex].barRods) {
                            sum += rod.toY;
                          }
                          final avg = sum /
                              showingBarGroups[touchedGroupIndex]
                                  .barRods
                                  .length;

                          showingBarGroups[touchedGroupIndex] =
                              showingBarGroups[touchedGroupIndex].copyWith(
                            barRods: showingBarGroups[touchedGroupIndex]
                                .barRods
                                .map((rod) {
                              return rod.copyWith(
                                  toY: avg,
                                  color:
                                      widget.theme.themeData.primaryColorDark);
                            }).toList(),
                          );
                        }
                      });
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
                        getTitlesWidget: bottomTitles,
                        reservedSize: 42,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 50,
                        interval: 1,
                        getTitlesWidget: leftTitles,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  barGroups: showingBarGroups,
                  gridData: FlGridData(show: false),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      height: 18,
                      width: 18,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: widget.theme.themeData.splashColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                      child: Text(
                        "Sales",
                        style: widget.theme.themeData.textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                  child: Row(
                    children: [
                      Container(
                        height: 18,
                        width: 18,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: widget.theme.themeData.highlightColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                        child: Text("Deductions",
                            style: widget.theme.themeData.textTheme.bodySmall),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    // Change this number to set intervals
    int interval = (maxYAxis ~/ 10);
    if (value % interval == 0) {
      int roundedValue = value.toInt();
      text = roundedValue.toString();
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    var titlesReversed = _months;
    Iterable<String>? titles = titlesReversed?.reversed;

    final Widget text = Text(
      titles!.elementAt(value.toInt()),
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 8,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: widget.theme.themeData.splashColor,
          width: width,
        ),
        BarChartRodData(
          toY: y2,
          color: widget.theme.themeData.highlightColor,
          width: width,
        ),
      ],
    );
  }
}
