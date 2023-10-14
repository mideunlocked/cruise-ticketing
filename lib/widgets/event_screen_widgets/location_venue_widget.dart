import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'go_google_map.dart';
import 'padded_widget_event_screen.dart';

class LocationVenueWidget extends StatelessWidget {
  const LocationVenueWidget({
    super.key,
    required this.venue,
    required this.location,
    required this.latlng,
  });

  final String venue;
  final String location;
  final Map<String, dynamic> latlng;

  @override
  Widget build(BuildContext context) {
    var lightGradient = [
      Colors.black87.withOpacity(0.8),
      Colors.black12,
    ];
    // var darkGradient = [
    //   Colors.white38,
    //   Colors.white12,
    // ];

    return PaddedWidgetEventScreen(
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          // The horizontal rectangular container
          Container(
            width: 100.w,
            height: 6.h,
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors:
                    lightGradient, // changes UI acccording to device theme mode
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                // map pin custom icon
                Image.asset(
                  "assets/icons/placeholder.png",
                  height: 3.h,
                  width: 3.h,
                  color: Colors.white,
                ),

                // some space
                SizedBox(
                  width: 4.w,
                ),

                // Location and venue text widget
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // venue text widget
                    SizedBox(
                      width: 60.w,
                      child: Text(
                        venue,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    // location text widget
                    SizedBox(
                      width: 60.w,
                      child: Text(
                        location,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // directs users to google map for further info on getting to the venue
          GoToGoogleMapIcon(
            latlng: latlng,
          ),
        ],
      ),
    );
  }
}
