import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'padded_widget_event_screen.dart';

class DateTimeWidget extends StatelessWidget {
  const DateTimeWidget({
    super.key,
    required this.date,
    required this.time,
  });

  final String date;
  final String time;

  @override
  Widget build(BuildContext context) {
    // calendar widget light color
    var lightGradient = [
      Colors.black87.withOpacity(0.8),
      Colors.black12,
    ];

    // calendar widget dark color
    var darkGradient = [
      Colors.white38,
      Colors.white12,
    ];

    return PaddedWidgetEventScreen(
      child: Row(
        children: [
          Container(
            height: 8.h,
            width: 15.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: MediaQuery.platformBrightnessOf(context) ==
                        Brightness.light
                    ? lightGradient
                    : darkGradient, // changes UI acccording to device theme mode
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            alignment: Alignment.center,

            // custom calendar icon
            child: Image.asset(
              "assets/icons/calendar.png",
              height: 6.h,
              width: 6.w,
              color: Colors.white,
            ),
          ),

          // some space
          SizedBox(
            width: 3.w,
          ),

          // date and time widget
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // date text widget
              Text(
                date,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),

              // time text widget
              Text(time),
            ],
          ),
        ],
      ),
    );
  }
}
