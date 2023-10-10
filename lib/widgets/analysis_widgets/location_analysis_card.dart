import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../models/event_analysis.dart';
import 'analysis_card_title.dart';

class LocationAnalysisCard extends StatelessWidget {
  const LocationAnalysisCard({
    super.key,
    required this.data,
  });

  final EventAnalysis data;

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
      color: Colors.white60,
      fontSize: 12.sp,
      fontWeight: FontWeight.bold,
    );

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
                title: "Attendee's location breakdown",
              ),
              SizedBox(
                height: 5.h,
              ),
              Expanded(
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
                    sections: data.attendeeLocations
                        .map(
                          (e) => PieChartSectionData(
                            value: double.parse(
                              e["amount"].toString(),
                            ),
                            title: e["location"],
                            color: getRandomColor(),
                            radius: 100,
                            titleStyle: textStyle,
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }
}
