import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class GoToGoogleMapIcon extends StatelessWidget {
  const GoToGoogleMapIcon({
    super.key,
    required this.primaryColor,
  });

  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10.h,
      width: 18.w,
      decoration: const BoxDecoration(
          shape: BoxShape.circle, // makes container circular
          color: Colors.black87 // changes UI acccording to device theme mode
          ),
      alignment: Alignment.center,
      child: const Icon(
        // map icon
        Icons.map_rounded,
        color: Colors.white, // changes UI acccording to device theme mode
      ),
    );
  }
}
