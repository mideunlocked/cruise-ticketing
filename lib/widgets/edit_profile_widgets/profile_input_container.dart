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
      margin: EdgeInsets.symmetric(vertical: 2.h),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }
}
