import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../providers/event_provider.dart';
import '../widgets/general_widgets/custom_back_button.dart';
import '../widgets/home_screen_widgets/event_today_tile.dart';
import '../widgets/profile_widgets/profile_screen_pad.dart';
import '../widgets/profile_widgets/profile_tab_container.dart';
import '../widgets/profile_widgets/user_detail_card.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool isPast = true;
  bool isUpcoming = false;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var bodyMedium = textTheme.bodyMedium;
    var color = bodyMedium?.color;

    var sizedBoxH2 = SizedBox(
      height: 2.h,
    );
    var sizedBoxH1 = SizedBox(
      height: 1.h,
    );

    final eventProvider = Provider.of<EventProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            sizedBoxH2,
            ProfileScreenPad(
              child: Row(
                children: [
                  const CustomBackButton(),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    "_username",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            sizedBoxH1,
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    sizedBoxH1,
                    UserDetailCard(
                      of: of,
                      color: color,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      children: [
                        ProfileTabContainer(
                          title: "Past",
                          isActive: isPast,
                          borderColor: color ?? Colors.transparent,
                          toggleTab: () => toggleTab(),
                        ),
                        ProfileTabContainer(
                          title: "Upcoming",
                          isActive: isUpcoming,
                          borderColor: color ?? Colors.transparent,
                          toggleTab: () => toggleTab(),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    ProfileScreenPad(
                      child: isPast == true
                          ? ListView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: eventProvider.events
                                  .map(
                                    (e) => EventListTile(event: e),
                                  )
                                  .toList(),
                            )
                          : ListView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: eventProvider.events
                                  .map(
                                    (e) => EventListTile(event: e),
                                  )
                                  .toList(),
                            ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // function to toggle the custom tab bar
  void toggleTab() {
    setState(() {
      isPast == true
          ? {
              isPast = false,
              isUpcoming = true,
            }
          : {
              isUpcoming = false,
              isPast = true,
            };
    });
  }
}
