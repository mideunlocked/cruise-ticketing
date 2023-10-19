import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LobbyIconButton extends StatelessWidget {
  const LobbyIconButton({
    super.key,
    required this.iconUrl,
    required this.function,
  });

  final String iconUrl;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      constraints: BoxConstraints.loose(
        Size(6.w, 5.h),
      ),
      onPressed: () => function(),
      icon: Image.asset(
        "assets/icons/$iconUrl.png",
        color: Colors.black,
        height: 5.h,
        width: 8.w,
      ),
    );
  }
}
