import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    required this.function,
    this.isInactive = false,
    this.radius = 5,
  });

  final String title;
  final Function function;
  final bool isInactive;
  final double radius;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var primaryColor = of.primaryColor;

    // bool checkMode =
    //     MediaQuery.platformBrightnessOf(context) == Brightness.light;

    return InkWell(
      onTap: () => function(), // button custom function
      child: Container(
        width: 100.w,
        height: 5.h,
        margin: EdgeInsets.symmetric(
          vertical: 1.h,
        ),
        decoration: BoxDecoration(
          color: isInactive ? primaryColor.withOpacity(0.2) : primaryColor,
          borderRadius: BorderRadius.circular(radius),
        ),
        alignment: Alignment.center,
        child: Text(
          title, // button title
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isInactive
                ? Colors.black
                : Colors
                    .white, // checks if device is in dark or light mode and changes ui dynamically
          ),
        ),
      ),
    );
  }
}
