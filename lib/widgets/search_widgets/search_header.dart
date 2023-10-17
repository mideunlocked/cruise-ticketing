import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SearchHeader extends StatelessWidget {
  const SearchHeader({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w),
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
        ],
      ),
    );
  }
}
