import 'package:cruise/data.dart';
import 'package:cruise/widgets/general_widgets/custom_button.dart';
import 'package:cruise/widgets/general_widgets/profile_image.dart';
import 'package:cruise/widgets/home_screen_widgets/event_today_tile.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

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

    return SafeArea(
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
                            children: event
                                .getRange(0, 2)
                                .map(
                                  (e) => EventListTile(data: e),
                                )
                                .toList(),
                          )
                        : ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: event
                                .getRange(2, 4)
                                .map(
                                  (e) => EventListTile(data: e),
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
    );
  }

  Padding customDivider(Color? color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Divider(
        color: color?.withOpacity(0.1),
        thickness: 2.0,
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

class ProfileScreenPad extends StatelessWidget {
  const ProfileScreenPad({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 3.w,
      ),
      child: child,
    );
  }
}

class ProfileTabContainer extends StatelessWidget {
  const ProfileTabContainer({
    super.key,
    required this.title,
    required this.isActive,
    required this.toggleTab,
    required this.borderColor,
  });

  final String title;
  final Color borderColor;
  final bool isActive;
  final Function toggleTab;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        toggleTab();
      },
      child: Container(
        width: 50.w,
        height: 8.h,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: borderColor,
              width: isActive == true ? 4.0 : 1.0,
            ),
          ),
        ),
        alignment: Alignment.center,
        child: Text(title),
      ),
    );
  }
}

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({
    super.key,
    required this.color,
  });

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          "Profile",
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        ProfileIconButton(
          iconUrl: "add",
          onPressed: () {
            Navigator.pushNamed(context, "/CreateEventScreen");
          },
          color: color ?? Colors.transparent,
        ),
        ProfileIconButton(
          iconUrl: "more_circular",
          onPressed: () => showMoreBottomSheet(context),
          color: color ?? Colors.transparent,
        ),
      ],
    );
  }

  void showMoreBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (ctx) => const ProfileBottomSheet(),
    );
  }
}

class ProfileBottomSheet extends StatelessWidget {
  const ProfileBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 2.w,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 2.h,
            ),
            MoreListTileAsset(
              title: "Manage events",
              iconUrl: "calendar",
              function: () {},
            ),
            MoreListTileAsset(
              title: "Tickets",
              iconUrl: "tickets",
              function: () {},
            ),
            MoreListTileIcon(
              title: "Saved",
              icon: Icons.favorite_outline_rounded,
              function: () {},
            ),
            MoreListTileIcon(
              icon: Icons.info_outline_rounded,
              title: "Help center",
              function: () {},
            ),
            MoreListTileIcon(
              icon: Icons.star_outline_rounded,
              title: "Rate us",
              function: () {},
            ),
            MoreListTileAsset(
              title: "Sign out",
              iconUrl: "exit",
              function: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class MoreListTileIcon extends StatelessWidget {
  const MoreListTileIcon({
    super.key,
    required this.icon,
    required this.title,
    required this.function,
  });

  final IconData icon;
  final String title;
  final Function function;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var bodyMedium = textTheme.bodyMedium;
    var color = bodyMedium?.color;

    return ListTile(
      horizontalTitleGap: 1.w,
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        title,
        style: bodyMedium?.copyWith(color: null),
      ),
      onTap: () {
        function();
      },
    );
  }
}

class MoreListTileAsset extends StatelessWidget {
  const MoreListTileAsset({
    super.key,
    required this.iconUrl,
    required this.title,
    required this.function,
  });

  final String iconUrl;
  final String title;
  final Function function;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var bodyMedium = textTheme.bodyMedium;
    var color = bodyMedium?.color;

    bool isSignOut = title.contains("out");

    return ListTile(
      horizontalTitleGap: 1.w,
      leading: Image.asset(
        "assets/icons/$iconUrl.png",
        color: isSignOut ? Colors.red : color,
        height: 6.h,
        width: 6.w,
      ),
      title: Text(
        title,
        style: bodyMedium?.copyWith(
          color: isSignOut ? Colors.red : null,
        ),
      ),
      onTap: () {
        function();
      },
    );
  }
}

class ProfileIconButton extends StatelessWidget {
  const ProfileIconButton({
    super.key,
    required this.iconUrl,
    required this.onPressed,
    required this.color,
  });

  final Color color;
  final String iconUrl;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        onPressed();
      },
      icon: Image.asset(
        "assets/icons/$iconUrl.png",
        color: color,
        height: 5.h,
        width: 6.w,
      ),
    );
  }
}

class UserDetailCard extends StatelessWidget {
  const UserDetailCard({
    super.key,
    required this.of,
    required this.color,
  });

  final ThemeData of;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(
      height: 1.h,
    );
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 3.w),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 1.h),
              child: const ProfileImage(
                imageUrl:
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTApbxj4499GJJWMYvKUVnzMUBJBt1b_Aob0A&usqp=CAU",
                radius: 70.0,
              ),
            ),
            Text(
              "John Doe",
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "@johndoe",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: of.primaryColor,
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UserNumberData(
                  color: color,
                  title: "Hosted",
                  data: "10",
                ),
                UserNumberData(
                  color: color,
                  title: "Attended",
                  data: "51",
                ),
                UserNumberData(
                  color: color,
                  title: "Followers",
                  data: "100k",
                ),
                UserNumberData(
                  color: color,
                  title: "Following",
                  data: "121",
                ),
              ],
            ),
            SizedBox(
              height: 4.h,
            ),
            Row(
              children: [
                Text(
                  "Bio",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
            sizedBox,
            const Text(
              "Passionate event organizer dedicated to creating unforgettable experiences. Expert in coordinating logistics, engaging activities, and ensuring seamless execution. Committed to turning visions into remarkable events.",
            ),
            SizedBox(
              height: 3.h,
            ),
            CustomButton(
              title: "Edit profile",
              function: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class UserNumberData extends StatelessWidget {
  const UserNumberData({
    super.key,
    required this.color,
    required this.data,
    required this.title,
  });

  final Color? color;
  final String data;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          data,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 8.sp,
            color: color?.withOpacity(0.5),
          ),
        ),
      ],
    );
  }
}
