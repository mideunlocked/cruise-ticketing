import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:lottie/lottie.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({
    super.key,
    required this.title,
    required this.subTitle,
  });

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LottieBuilder.asset("assets/lottie/empty_list.json"),
        SizedBox(
          height: 2.h,
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 1.h,
        ),
        Text(subTitle),
      ],
    );
  }
}
