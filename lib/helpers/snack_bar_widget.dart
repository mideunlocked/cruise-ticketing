import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomSnackBar {
  static showCustomSnackBar(
    GlobalKey<ScaffoldMessengerState> scaffoldKey,
    String message, {
    Color color = Colors.red,
  }) {
    scaffoldKey.currentState?.showSnackBar(
      SnackBar(
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        content: SizedBox(
          width: 80,
          child: Text(message),
        ),
        backgroundColor: color,
      ),
    );
  }
}
