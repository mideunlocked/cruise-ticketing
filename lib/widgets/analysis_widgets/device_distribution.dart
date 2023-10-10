import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../models/event_analysis.dart';
import 'analysis_card_title.dart';

class DeviceDistribution extends StatelessWidget {
  const DeviceDistribution({super.key, required this.data});

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
          width: 100.w,
          child: Column(
            children: [
              const AnalysisCardTitle(
                title: "Device distribution",
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: data.deviceSales
                    .map(
                      (e) => Column(
                        children: [
                          Text(
                            e["amount"].toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 15.sp,
                            ),
                          ),
                          Text(
                            e["platform"] ?? "",
                            style: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
