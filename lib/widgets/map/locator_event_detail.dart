import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'detail_image_widget.dart';
import 'event_detail_column.dart';
import 'event_duration_widget.dart';
import 'get_directions_button.dart';
import 'go_to_event_screen.dart';

// ignore: must_be_immutable
class LocatorEventDetail extends StatefulWidget {
  LocatorEventDetail({
    super.key,
    required this.sheetPosition,
    required this.getDirection,
    required this.data,
    required this.duration,
  });

  double sheetPosition;
  final Map<String, dynamic> duration;
  final Function getDirection;
  final Map<String, dynamic> data;

  @override
  State<LocatorEventDetail> createState() => _LocatorEventDetailState();
}

class _LocatorEventDetailState extends State<LocatorEventDetail> {
  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var scaffoldBackgroundColor = of.scaffoldBackgroundColor;

    return AnimatedContainer(
      // animated controller for mimicking bottom sheet
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height - widget.sheetPosition,
      ),
      child: GestureDetector(
        onVerticalDragUpdate: (details) {
          setState(() {
            widget.sheetPosition += details.delta.dy;
            if (widget.sheetPosition < 0) {
              widget.sheetPosition = 0;
            }
          });
        },
        onVerticalDragEnd: (details) {
          setState(() {
            if (widget.sheetPosition < 150) {
              widget.sheetPosition = 0;
            } else {
              widget.sheetPosition = 300; // Adjust the height as needed
            }
          });
        },
        child: Container(
          height: 32.h,
          decoration: BoxDecoration(
            color: MediaQuery.platformBrightnessOf(context) == Brightness.light
                ? Colors.grey[300]
                : const Color.fromARGB(255, 0, 1, 36),
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                // image and event detail widget
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // display event image
                    DetailImageWidget(
                      image: widget.data["imageUrl"] ?? "",
                    ),

                    // some spacing
                    SizedBox(
                      width: 3.w,
                    ),

                    // event name, venue, host and date
                    EventDetailColumn(
                      widget: widget,
                    ),
                  ],
                ),

                // some spacing
                SizedBox(
                  height: 2.h,
                ),

                // container functions
                SizedBox(
                  height: 4.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // get event directions info
                      GetDirectionsButton(
                        getDirection: widget.getDirection,
                      ),

                      // event estimated duration from origin to destination
                      EventDurationWidget(
                        duration: widget.duration["duration"] ?? "",
                        icon: Icon(
                          Icons.directions_walk_rounded,
                          color: scaffoldBackgroundColor,
                        ),
                        color: Colors.grey,
                      ),

                      // go to even screen button
                      GoToEventScreen(
                        widget: widget,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
