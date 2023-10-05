import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProfileScreenPad extends StatelessWidget {
  const ProfileScreenPad({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 3.w,
      ),
      child: child,
    );
  }
}
