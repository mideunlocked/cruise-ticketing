import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    required this.function,
  });

  final String title;
  final Function function;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var primaryColor = of.primaryColor;

    return InkWell(
      onTap: () => function(), // button custom function
      child: Container(
        width: 100.w,
        height: 5.h,
        margin: EdgeInsets.symmetric(
          vertical: 1.h,
        ),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
        alignment: Alignment.center,
        child: Text(
          title, // button title
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: MediaQuery.platformBrightnessOf(context) == Brightness.light
                ? Colors.white
                : null, // checks if device is in dark or light mode and changes ui dynamically
          ),
        ),
      ),
    );
  }
}
