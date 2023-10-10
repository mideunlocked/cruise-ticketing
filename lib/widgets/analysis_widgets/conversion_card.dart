import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../models/event_analysis.dart';
import 'analysis_card_title.dart';
import 'piechart_custom_value.dart';

class ConversionCard extends StatelessWidget {
  const ConversionCard({
    super.key,
    required this.data,
  });

  final EventAnalysis data;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 2.h,
          horizontal: 4.w,
        ),
        child: SizedBox(
          height: 40.h,
          width: 100.w,
          child: Column(
            children: [
              const AnalysisCardTitle(
                title: "Event listing conversion rate",
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ConversionPieChart(data: data),
                    SizedBox(
                      width: 5.w,
                    ),
                    ConversionBreakdown(
                      data: data,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ConversionBreakdown extends StatelessWidget {
  const ConversionBreakdown({
    super.key,
    required this.data,
  });

  final EventAnalysis data;

  @override
  Widget build(BuildContext context) {
    double conversionPercent = data.conversionPercentage();
    String percent = conversionPercent.toString();

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PieChartCustomValue(
          data: data.totalViews,
          title: "Views",
          totalChart: 0,
          showPercent: false,
          iconColor: Colors.blue[900]!,
        ),
        PieChartCustomValue(
          data: data.ticketSold,
          title: "Sales",
          totalChart: data.totalViews,
          iconColor: Colors.green[900]!,
        ),
        Material(
          elevation: 5,
          animationDuration: const Duration(
            seconds: 5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: SizedBox(
            width: 25.w,
            height: 4.h,
            child: Text(
              "$percent%",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 15.sp,
                color: conversionPercent < 40
                    ? Colors.red
                    : conversionPercent < 60
                        ? Colors.yellow
                        : Colors.green,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ConversionPieChart extends StatelessWidget {
  const ConversionPieChart({
    super.key,
    required this.data,
  });

  final EventAnalysis data;

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
      color: Colors.white60,
      fontSize: 14.sp,
      fontWeight: FontWeight.bold,
    );

    return Expanded(
      child: PieChart(
        swapAnimationCurve: Curves.easeIn,
        swapAnimationDuration: const Duration(
          seconds: 2,
        ),
        PieChartData(
          sectionsSpace: 2.w,
          borderData: FlBorderData(
            show: false,
          ),
          sections: [
            PieChartSectionData(
              value: data.totalViews.toDouble(),
              title: "Views",
              color: Colors.blue[900],
              radius: 100,
              titleStyle: textStyle,
            ),
            PieChartSectionData(
              value: data.ticketSold.toDouble(),
              title: "Sales",
              color: Colors.green[900],
              radius: 100,
              titleStyle: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}
