import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TextFieldTitle extends StatelessWidget {
  const TextFieldTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Text(
        title,
        style: const TextStyle(letterSpacing: 1.0),
      ),
    );
  }
}
