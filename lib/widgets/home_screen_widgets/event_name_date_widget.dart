import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class EventNameAndDateWidget extends StatelessWidget {
  const EventNameAndDateWidget({
    super.key,
    required this.data,
    this.isStart = false,
    this.largeText = true,
  });

  // event passed date
  final dynamic data;
  // checks if column should align vertically from start or end
  final bool isStart;
  // check if the text requires a larger font or smaller font
  final bool largeText;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var primaryColor = of.primaryColor;

    // check device is in dark mode or light mode
    bool checkMode =
        MediaQuery.platformBrightnessOf(context) == Brightness.light;

    // gets time from the passed data and splits it so we can have the
    //start time and ending time in a list
    var time = data["time"].toString().split(" - ");

    // gets the start time
    var startTime = time[0];

    // text span text style
    var dateTimeStyle = TextStyle(
      fontSize: largeText == true ? 8.sp : 7.sp,
      color: largeText != true
          ? checkMode
              ? Colors.black
              : Colors.white
          : Colors.white,
      fontWeight: FontWeight.w500,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment:
          isStart == false ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        // date and time widget in a text span
        RichText(
          text: TextSpan(
            text: data["date"] ?? "",
            style: dateTimeStyle,
            children: <TextSpan>[
              TextSpan(text: " ~ $startTime", style: dateTimeStyle),
            ],
          ),
        ),

        // some spacing
        SizedBox(
          height: 0.5.h,
        ),

        // event name text widget
        SizedBox(
          width: 100.w,
          child: Text(
            data["name"] ?? "",
            softWrap: true,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: largeText == true ? 14.sp : 10.sp,
              color: largeText == true
                  ? checkMode
                      ? Colors.white
                      : Colors.white
                  : primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
