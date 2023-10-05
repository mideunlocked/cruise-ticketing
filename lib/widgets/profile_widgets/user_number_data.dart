import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class UserNumberData extends StatelessWidget {
  const UserNumberData({
    super.key,
    required this.color,
    required this.data,
    required this.title,
  });

  final Color? color;
  final String data;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          data,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 8.sp,
            color: color?.withOpacity(0.5),
          ),
        ),
      ],
    );
  }
}
