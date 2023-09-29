import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TextBar extends StatelessWidget {
  const TextBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 90.h,
      child: Text(
        "Locator",
        style: TextStyle(
          color: Colors.black54,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          letterSpacing: 4.0,
        ),
      ),
    );
  }
}
