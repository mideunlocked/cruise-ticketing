import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ThirdPartyAuthButton extends StatelessWidget {
  const ThirdPartyAuthButton({
    super.key,
    required this.iconUrl,
    required this.title,
    this.color = Colors.transparent,
  });

  final String iconUrl;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 7.h,
      margin: EdgeInsets.symmetric(vertical: 1.h),
      padding: EdgeInsets.symmetric(horizontal: 2.5.w),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            children: [
              Image.asset(
                "assets/icons/$iconUrl.png",
                color: color == Colors.transparent ? null : color,
                height: 6.h,
                width: 6.w,
              ),
            ],
          ),
          Text(
            "Continue with $title",
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
