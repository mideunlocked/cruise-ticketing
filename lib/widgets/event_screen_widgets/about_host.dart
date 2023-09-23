import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../general_widgets/profile_image.dart';
import 'event_screen_title_widget.dart';
import 'padded_widget_event_screen.dart';

class AboutHost extends StatelessWidget {
  const AboutHost({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var primaryColor = of.primaryColor;

    return PaddedWidgetEventScreen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // host header widget
          const EventScreenTitleWidget(title: "HOST"),

          // row holding host profile image, full name and username
          Row(
            children: [
              // host profile image
              ProfileImage(
                imageUrl:
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTApbxj4499GJJWMYvKUVnzMUBJBt1b_Aob0A&usqp=CAU",
                radius: 17.sp,
              ),

              // some space
              SizedBox(width: 2.w),

              // column holding host full name and username
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // host full name
                  Text(
                    "John Doe",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),

                  // host username
                  Text(
                    "@johndoe",
                    style: TextStyle(
                      // changes UI acccording to device theme mode
                      color: MediaQuery.platformBrightnessOf(context) ==
                              Brightness.light
                          ? Colors.black
                          : primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
