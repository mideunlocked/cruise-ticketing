import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../widgets/event_screen_widgets/about_widget.dart';
import '../widgets/event_screen_widgets/buy_tickets_button.dart';
import '../widgets/event_screen_widgets/custom_tab_bar.dart';
import '../widgets/event_screen_widgets/details_widget.dart';
import '../widgets/event_screen_widgets/event_image_widget.dart';

class EventScreen extends StatefulWidget {
  static const routeName = "/EventScreen";

  const EventScreen({
    super.key,
    required this.durationData,
    required this.eventData,
  });

  final Map<String, dynamic> durationData;
  final Map<String, dynamic> eventData;

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  // holds about is selected
  bool isAbout = true;

  // holds detail is selected
  bool isDetails = false;

  // function to toggle the custom tab bar
  void toggleTab() {
    setState(() {
      isAbout == true
          ? {
              isAbout = false,
              isDetails = true,
            }
          : {
              isDetails = false,
              isAbout = true,
            };
    });
  }

  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(height: 3.h);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                // custom image widget which also holds the back button
                EventImageWidget(
                  imageUrl: widget.eventData["imageUrl"] ?? "",
                ),

                // this widget holds the name of the event and the custom tab bar
                Positioned(
                  top: 48.h,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // event name
                        SizedBox(
                          width: 90.w,
                          child: Text(
                            widget.eventData["name"] ?? "",
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2.0,
                              wordSpacing: 4.0,
                            ),
                          ),
                        ),

                        // some space
                        SizedBox(height: 1.h),

                        // custom tab bar
                        CustomTabBar(
                          toggleTab: toggleTab,
                          isAbout: isAbout,
                          isDetails: isDetails,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // about and details widget
            isAbout == true // checks if about tab is currently selected
                ?
                // then displays is
                About(
                    sizedBox: sizedBox,
                    widget: widget,
                  )
                :
                // else details is selected and displays it
                Details(
                    widget: widget,
                    sizedBox: sizedBox,
                  ),

            // some space
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),

      // buy ticket floating action button which also
      //intiates the pricing and category bottom sheet
      floatingActionButton: BuyTicketButton(
        data: widget.eventData,
      ),
    );
  }
}
