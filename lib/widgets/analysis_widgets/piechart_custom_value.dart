import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/format_number.dart';

class PieChartCustomValue extends StatelessWidget {
  const PieChartCustomValue({
    super.key,
    required this.data,
    required this.title,
    required this.totalChart,
    required this.iconColor,
    this.showPercent = true,
  });

  final int data;
  final String title;
  final int totalChart;
  final Color iconColor;
  final bool showPercent;

  @override
  Widget build(BuildContext context) {
    double percentage = (data / totalChart) * 100;
    String approximatePercent = percentage.toStringAsFixed(2);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.circle_rounded,
              color: iconColor,
              size: 10.sp,
            ),
            SizedBox(
              width: 3.sp,
            ),
            Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              formatData(
                data,
              ),
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 15.sp,
              ),
            ),
            SizedBox(
              width: 3.sp,
            ),
            showPercent
                ? Text(
                    "($approximatePercent%)",
                    style: TextStyle(
                      fontSize: 8.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ],
    );
  }

  String formatData(int data) {
    String formatedData = FormatNumber.formatLargeNumber(data);

    return formatedData;
  }
}
