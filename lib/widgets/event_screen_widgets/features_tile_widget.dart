import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class FeaturesTileWidget extends StatelessWidget {
  const FeaturesTileWidget({
    super.key,
    required this.title,
    this.isPicked = false,
  });

  final String title;
  final bool isPicked;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var primaryColor = of.primaryColor;

    // check and changes UI dynamicaaly according to device theme mode
    bool checkMode =
        MediaQuery.platformBrightnessOf(context) == Brightness.light;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 1.w),
      decoration: BoxDecoration(
        color: checkMode
            ? isPicked == true
                ? primaryColor.withOpacity(0.3)
                : primaryColor.withOpacity(0.1)
            : isPicked == true
                ? primaryColor.withOpacity(0.3)
                : primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(
        title, // features data
        style: TextStyle(
          fontWeight: isPicked == true ? FontWeight.w900 : FontWeight.bold,
          color: checkMode ? Colors.black : Colors.white,
          letterSpacing: 2.0,
        ),
      ),
    );
  }
}
