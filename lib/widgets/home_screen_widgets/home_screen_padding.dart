import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HomeScreenPadding extends StatelessWidget {
  const HomeScreenPadding({super.key, required this.child});

  final Widget child; // widget to apply the padding to

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: child, // child which padding is added to
    );
  }
}
