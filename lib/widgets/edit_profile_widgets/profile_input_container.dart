import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProfileInputContainer extends StatelessWidget {
  const ProfileInputContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6.5.h,
      width: 100.w,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
