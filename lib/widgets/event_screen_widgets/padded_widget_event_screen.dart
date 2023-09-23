import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PaddedWidgetEventScreen extends StatelessWidget {
  const PaddedWidgetEventScreen({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: child,
    );
  }
}
