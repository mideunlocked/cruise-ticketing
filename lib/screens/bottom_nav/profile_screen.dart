import 'package:cruise/widgets/general_widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/users.dart';
import '../../providers/event_provider.dart';
import '../../providers/users_provider.dart';
import '../../widgets/general_widgets/empty_list_widget.dart';
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

  bool isFetchingUser = false;
  bool isFectchingEvents = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    getCurrentUserData();
    getCurrentUserEvents();
  }

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var bodyMedium = textTheme.bodyMedium;
    var color = bodyMedium?.color;

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

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, "/");
        throw 1;
      },
      child: RefreshIndicator(
        onRefresh: () async {
          getCurrentUserData();
          getCurrentUserEvents();
        },
        color: Theme.of(context).primaryColor,
        child: Consumer<UsersProvider>(builder: (context, userProvider, child) {
          Users user = userProvider.userData;

          return SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 1.h,
                ),
                ProfileScreenPad(
                  child: ProfileAppBar(color: color),
                ),
                isFetchingUser && user.id.isEmpty
                    ? CustomLoadingIndicator(height: 50.h, width: 50.w)
                    : Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              UserDetailCard(
                                of: of,
                                color: color,
                                user: user,
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
                              isFectchingEvents
                                  ? CustomLoadingIndicator(
                                      height: 50.h, width: 50.w)
                                  : SizedBox(
                                      height: 60.h,
                                      child: ProfileScreenPad(
                                        child: user.hosted!.isEmpty
                                            ? emptyEventsList
                                            : isPast == true
                                                ? ListView(
                                                    shrinkWrap: true,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    children: eventProvider
                                                            .events
                                                            .where((e) {
                                                      if (e.hostId == user.id &&
                                                          e.isValid == false) {
                                                        return true;
                                                      }

                                                      return false;
                                                    }).isEmpty
                                                        ? [emptyPastEvents]
                                                        : eventProvider.events
                                                            .where((e) {
                                                              if (e.hostId ==
                                                                      user.id &&
                                                                  e.isValid ==
                                                                      false) {
                                                                return true;
                                                              }

                                                              return false;
                                                            })
                                                            .map(
                                                              (e) =>
                                                                  EventListTile(
                                                                      event: e),
                                                            )
                                                            .toList(),
                                                  )
                                                : ListView(
                                                    shrinkWrap: true,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    children: eventProvider
                                                            .events
                                                            .where((e) {
                                                      if (e.hostId == user.id &&
                                                          e.isValid == true) {
                                                        return true;
                                                      }

                                                      return false;
                                                    }).isEmpty
                                                        ? [emptyUpcomingEvents]
                                                        : eventProvider.events
                                                            .where((e) {
                                                              if (e.hostId ==
                                                                      user.id &&
                                                                  e.isValid ==
                                                                      true) {
                                                                return true;
                                                              }

                                                              return false;
                                                            })
                                                            .map(
                                                              (e) =>
                                                                  EventListTile(
                                                                      event: e),
                                                            )
                                                            .toList(),
                                                  ),
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
          );
        }),
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

  void getCurrentUserData() async {
    setState(() {
      isFetchingUser = true;
    });

    final userProvider = Provider.of<UsersProvider>(context, listen: false);
    await userProvider.getCurrentUser();

    setState(() {
      isFetchingUser = false;
    });
  }

  void getCurrentUserEvents() async {
    setState(() {
      isFectchingEvents = true;
    });

    final eventProvider = Provider.of<EventProvider>(context, listen: false);
    await eventProvider.getUserEvents();

    setState(() {
      isFectchingEvents = false;
    });
  }
}
