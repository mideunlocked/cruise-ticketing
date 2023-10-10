import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../helpers/format_number.dart';
import '../../models/event_analysis.dart';
import 'analysis_card_title.dart';

class GenderDistribution extends StatelessWidget {
  const GenderDistribution({
    super.key,
    required this.data,
  });

  final EventAnalysis data;

  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(
      height: 2.w,
    );
    var sizedBoxH5 = SizedBox(
      height: 5.h,
    );

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.h),
        child: Column(
          children: [
            const AnalysisCardTitle(
              title: "Gender distribution",
            ),
            sizedBoxH5,
            GenderBarChart(
              ticketSold: data.ticketSold.toDouble(),
              data: data.genders,
            ),
            sizedBoxH5,
            const AnalysisCardTitle(
              title: "Gender distribution in numbers",
            ),
            sizedBox,
            GenderBreakdown(
              data: data.genders,
            ),
            sizedBox,
          ],
        ),
      ),
    );
  }
}

class GenderBarChart extends StatefulWidget {
  const GenderBarChart(
      {super.key, required this.ticketSold, required this.data});

  final double ticketSold;
  final List<dynamic> data;

  @override
  State<GenderBarChart> createState() => _GenderBarChartState();
}

class _GenderBarChartState extends State<GenderBarChart> {
  int initialIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: BarChart(
        BarChartData(
          backgroundColor: Colors.transparent,
          maxY: widget.ticketSold,
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: getBottomTiles,
              ),
            ),
          ),
          barGroups: widget.data
              .map(
                (e) => BarChartGroupData(
                  x: 1,
                  barRods: [
                    BarChartRodData(
                      toY: double.parse(
                        e["amount"].toString(),
                      ),
                      color: Colors.black,
                      width: 5.w,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(5),
                      ),
                      backDrawRodData: BackgroundBarChartRodData(
                        fromY: double.infinity,
                        show: true,
                        color: Colors.grey[200],
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  void increaseIndex() {
    if (initialIndex < widget.data.length - 1) {
      initialIndex = initialIndex + 1;
    } else {
      initialIndex = 0;
    }
  }

  Widget getBottomTiles(double value, TitleMeta meta) {
    Widget text = const Text("null");
    dynamic i;

    for (i in widget.data) {
      if (i["id"] == initialIndex) {
        text = Text(
          i["gender"],
        );
      }
    }

    increaseIndex();

    return SideTitleWidget(
      axisSide: AxisSide.bottom,
      space: 2,
      child: text,
    );
  }
}

class GenderBreakdown extends StatelessWidget {
  const GenderBreakdown({super.key, required this.data});

  final List<dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: data
          .map(
            (e) => Padding(
              padding: EdgeInsets.only(
                bottom: 1.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${e["gender"]}:",
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    FormatNumber.formatLargeNumber(
                      int.parse(
                        e["amount"].toString(),
                      ),
                    ),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
