import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // checks if device is in light mode or dark mode
    bool checkDeviceMode =
        MediaQuery.platformBrightnessOf(context) == Brightness.light;

    return SizedBox(
      height: 6.h,
      child: InkWell(
        onTap: () => Navigator.pop(context),
        child: Container(
          width: 12.w,
          height: 6.h,
          decoration: BoxDecoration(
            color: checkDeviceMode
                ? Colors.black12
                : Theme.of(context).primaryColor.withOpacity(0.2),
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
