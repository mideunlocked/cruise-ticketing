import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../models/users.dart';
import '../providers/event_provider.dart';
import '../providers/users_provider.dart';
import '../widgets/general_widgets/custom_app_bar.dart';
import '../widgets/general_widgets/empty_list_widget.dart';
import '../widgets/home_screen_widgets/event_today_tile.dart';
import '../widgets/profile_widgets/profile_screen_pad.dart';
import '../widgets/profile_widgets/profile_tab_container.dart';
import '../widgets/profile_widgets/user_detail_card.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({
    super.key,
    required this.userId,
  });

  final String userId;

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  Users? user;

  bool isPast = true;
  bool isUpcoming = false;

  @override
  void initState() {
    super.initState();

    getUser();
  }

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var bodyMedium = textTheme.bodyMedium;
    var color = bodyMedium?.color;

    var sizedBoxH1 = SizedBox(
      height: 1.h,
    );

    final eventProvider = Provider.of<EventProvider>(context);

    const emptyPastEvents = EmptyListWidget(
      title: "No past events",
      subTitle: "No past events founds for this user",
    );
    const emptyUpcomingEvents = EmptyListWidget(
      title: "No upcoming events",
      subTitle: "No upcoming events founds for this user",
    );
    const emptyEventsList = EmptyListWidget(
      title: "No events",
      subTitle: "No events founds for this user",
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(title: user?.username ?? "", bottomPadding: 0),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    sizedBoxH1,
                    UserDetailCard(
                        of: of, color: color, userId: user?.id ?? ""),
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
                    SizedBox(
                      height: 80.h,
                      child: ProfileScreenPad(
                        child: user!.hosted.isEmpty
                            ? emptyEventsList
                            : isPast == true
                                ? ListView(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    children: eventProvider.events.where((e) {
                                      if (e.hostId == user!.id &&
                                          e.isValid == false) {
                                        return true;
                                      }

                                      return false;
                                    }).isEmpty
                                        ? [emptyPastEvents]
                                        : eventProvider.events
                                            .where((e) {
                                              if (e.hostId == user!.id &&
                                                  e.isValid == false) {
                                                return true;
                                              }

                                              return false;
                                            })
                                            .map(
                                              (e) => EventListTile(event: e),
                                            )
                                            .toList(),
                                  )
                                : ListView(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    children: eventProvider.events.where((e) {
                                      if (e.hostId == user!.id &&
                                          e.isValid == true) {
                                        return true;
                                      }

                                      return false;
                                    }).isEmpty
                                        ? [emptyUpcomingEvents]
                                        : eventProvider.events
                                            .where((e) {
                                              if (e.hostId == user!.id &&
                                                  e.isValid == true) {
                                                return true;
                                              }

                                              return false;
                                            })
                                            .map(
                                              (e) => EventListTile(event: e),
                                            )
                                            .toList(),
                                  ),
                      ),
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

  void getUser() {
    var userProvider = Provider.of<UsersProvider>(context, listen: false);

    user = userProvider.getUser(widget.userId);
  }
}
