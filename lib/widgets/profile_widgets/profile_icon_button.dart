import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';

class ProfileIconButton extends StatelessWidget {
  const ProfileIconButton({
    super.key,
    required this.iconUrl,
    required this.onPressed,
    required this.color,
  });

  final Color color;
  final String iconUrl;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        onPressed();
      },
      icon: Image.asset(
        "assets/icons/$iconUrl.png",
        color: color,
        height: 5.h,
        width: 6.w,
      ),
    );
  }
}
