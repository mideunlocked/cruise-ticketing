import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AnalysisCardTitle extends StatelessWidget {
  const AnalysisCardTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 12.sp,
      ),
    );
  }
}
