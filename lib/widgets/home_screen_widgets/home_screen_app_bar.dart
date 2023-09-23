import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'home_screen_padding.dart';

class HomeScreenAppBar extends StatelessWidget {
  const HomeScreenAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var primaryColor = of.primaryColor;

    // checks if device is in light mode or dark mode
    bool checkDeviceMode =
        MediaQuery.platformBrightnessOf(context) == Brightness.light;

    return HomeScreenPadding(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // App name CRUISE
          Text(
            "Cruise",
            style: TextStyle(
              letterSpacing: 10.0,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),

          // some space
          const Spacer(),

          // notification bell icon
          Icon(
            Icons.notifications_rounded,
            // check if the device is light mode or dark and update
            //the ui accoridingly
            color: checkDeviceMode ? primaryColor : Colors.white,
          ),
        ],
      ),
    );
  }
}
