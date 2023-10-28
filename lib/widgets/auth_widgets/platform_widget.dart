import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PlatformWidget extends StatelessWidget {
  const PlatformWidget({
    super.key,
    required this.iconUrl,
    required this.function,
  });

  final String iconUrl;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: InkWell(
        onTap: () => function(),
        borderRadius: BorderRadius.circular(50),
        highlightColor: Colors.transparent,
        child: Image.asset(
          "assets/icons/$iconUrl.png",
          height: 12.h,
          width: 12.w,
        ),
      ),
    );
  }
}
