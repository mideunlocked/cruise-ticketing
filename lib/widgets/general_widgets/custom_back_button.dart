import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
    this.isInitial = false,
  });

  final bool isInitial;

  @override
  Widget build(BuildContext context) {
    // checks if device is in light mode or dark mode
    // bool checkDeviceMode =
    //     MediaQuery.platformBrightnessOf(context) == Brightness.light;

    return SizedBox(
      height: 4.h,
      child: InkWell(
        onTap: () {
          isInitial
              ? Navigator.pushNamedAndRemoveUntil(
                  context, "/", (route) => false)
              : Navigator.pop(context);
        },
        child: Container(
          width: 10.w,
          height: 4.h,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.black45, Colors.black12],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
