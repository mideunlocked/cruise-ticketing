import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../models/event_analysis.dart';
import 'analysis_card_title.dart';
import 'revenue_tile.dart';

class RevenueAnalysis extends StatelessWidget {
  const RevenueAnalysis({
    super.key,
    required this.data,
    required this.pricing,
  });

  final EventAnalysis data;
  final dynamic pricing;

  @override
  Widget build(BuildContext context) {
    dynamic typeRevenue = data.calculateTypeRevenue(pricing);
    double estimate = data.getEstimatedRevenue(pricing);
    double current = data.getCurrentRevenue(typeRevenue);

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      child: SizedBox(
        height: 22.h,
        width: 100.w,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.h),
          child: Column(
            children: [
              const AnalysisCardTitle(
                title: "Revenue (NGN)",
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RevenueTile(
                    data: estimate,
                    title: "Estimate",
                  ),
                  RevenueTile(
                    data: current,
                    title: "Current",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
