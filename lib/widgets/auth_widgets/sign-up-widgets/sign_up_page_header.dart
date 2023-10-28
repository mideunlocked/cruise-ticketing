import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SignUpPageHeader extends StatelessWidget {
  const SignUpPageHeader({
    super.key,
    required this.title,
    required this.subTitle,
  });

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 30.sp,
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          subTitle,
          style: const TextStyle(color: Colors.black45),
        ),
      ],
    );
  }
}
