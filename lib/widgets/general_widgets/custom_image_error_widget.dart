import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomImageErrorWidget extends StatelessWidget {
  const CustomImageErrorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "CRUISE",
        style: TextStyle(
          color: Colors.black12,
          fontSize: 25.sp,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
