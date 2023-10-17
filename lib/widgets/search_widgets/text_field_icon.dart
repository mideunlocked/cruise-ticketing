import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TextFieldIcon extends StatelessWidget {
  const TextFieldIcon({
    super.key,
    required this.iconUrl,
  });

  final String iconUrl;

  @override
  Widget build(BuildContext context) {
    // check and changes UI dynamicaaly according to device theme mode
    // bool checkMode =
    //     MediaQuery.platformBrightnessOf(context) == Brightness.light;

    return Image.asset(
      iconUrl,
      height: 3.h,
      width: 3.w,
      color: Colors.black38,
    );
  }
}
