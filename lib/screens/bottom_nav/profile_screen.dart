import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../providers/event_provider.dart';
import '../../widgets/home_screen_widgets/event_today_tile.dart';
import '../../widgets/profile_widgets/profile_app_bar.dart';
import '../../widgets/profile_widgets/profile_screen_pad.dart';
import '../../widgets/profile_widgets/profile_tab_container.dart';
import '../../widgets/profile_widgets/user_detail_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isPast = true;
  bool isUpcoming = false;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var bodyMedium = textTheme.bodyMedium;
    var color = bodyMedium?.color;

    final eventProvider = Provider.of<EventProvider>(context);

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, "/");
        throw 1;
      },
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 1.h,
            ),
            ProfileScreenPad(
              child: ProfileAppBar(color: color),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
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
