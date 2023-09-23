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
      decoration: BoxDecoration(
        shape: BoxShape.circle, // makes container circular
        color: MediaQuery.platformBrightnessOf(context) == Brightness.light
            ? Colors.black87
            : Colors.white, // changes UI acccording to device theme mode
      ),
      alignment: Alignment.center,
      child: Icon(
        // map icon
        Icons.map_rounded,
        color: MediaQuery.platformBrightnessOf(context) == Brightness.light
            ? Colors.white
            : primaryColor, // changes UI acccording to device theme mode
      ),
    );
  }
}
