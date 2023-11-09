import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/users.dart';
import '../../providers/users_provider.dart';
import '../general_widgets/custom_button.dart';
import '../general_widgets/profile_image.dart';
import 'event_screen_title_widget.dart';
import 'padded_widget_event_screen.dart';

class AboutHost extends StatefulWidget {
  const AboutHost({
    super.key,
    required this.host,
  });

  final Users? host;

  @override
  State<AboutHost> createState() => _AboutHostState();
}

class _AboutHostState extends State<AboutHost> {
  Users? currentUser;

  @override
  void initState() {
    super.initState();

    var userProvider = Provider.of<UsersProvider>(context, listen: false);

    currentUser = userProvider.userData;
  }

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var primaryColor = of.primaryColor;

    bool isHost = widget.host?.id == currentUser?.id;

    return PaddedWidgetEventScreen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 1.h,
          ),
          // host header widget
          const EventScreenTitleWidget(title: "HOST"),
          SizedBox(
            height: 1.h,
          ),
          // row holding host profile image, full name and username
          Row(
            children: [
              // host profile image
              ProfileImage(
                imageUrl: widget.host?.imageUrl ?? "",
                radius: 17.sp,
                userId: widget.host?.id ?? "",
              ),

              // some space
              SizedBox(width: 2.w),

              // column holding host full name and username
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // host full name
                  Text(
                    widget.host?.name ?? "",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),

                  // host username
                  Text(
                    "@${widget.host?.username ?? ""}",
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
              const Spacer(),
              isHost
                  ? const SizedBox()
                  : SizedBox(
                      width: 25.w,
                      height: 6.h,
                      child: CustomButton(
                        function: () {},
                        title: "Following",
                        radius: 15,
                        isInactive: true,
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
