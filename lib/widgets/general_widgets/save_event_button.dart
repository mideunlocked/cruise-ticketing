import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SaveEventButton extends StatelessWidget {
  const SaveEventButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // var of = Theme.of(context);
    // var primaryColor = of.primaryColor;

    // bool checkMode =
    //     MediaQuery.platformBrightnessOf(context) == Brightness.light;

    return Positioned(
      left: 70.w,
      top: 1.h,
      child: InkWell(
        onTap: () {},
        child: Container(
          height: 5.h,
          width: 12.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              colors: [Colors.white38, Colors.white10],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          alignment: Alignment.center,
          child: const Icon(
            Icons.favorite_outline_rounded,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
