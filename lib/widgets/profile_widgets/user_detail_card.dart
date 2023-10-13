import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/users.dart';
import '../../providers/users_provider.dart';
import '../general_widgets/custom_button.dart';
import '../general_widgets/profile_image.dart';
import 'user_number_data.dart';

class UserDetailCard extends StatefulWidget {
  const UserDetailCard({
    super.key,
    required this.of,
    required this.color,
    required this.userId,
  });

  final ThemeData of;
  final Color? color;
  final String userId;

  @override
  State<UserDetailCard> createState() => _UserDetailCardState();
}

class _UserDetailCardState extends State<UserDetailCard> {
  Users? user;
  dynamic userNumbers;
  bool isCurrentUser = false;

  @override
  void initState() {
    super.initState();

    getUserDetails();
  }

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
              child: ProfileImage(
                imageUrl: user?.imageUrl ?? "",
                radius: 70.0,
                isAuthUser: true,
                userId: user?.id ?? "",
              ),
            ),
            Text(
              user?.name ?? "",
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "@${user?.username}",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: widget.of.primaryColor,
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UserNumberData(
                  color: widget.color,
                  title: "Hosted",
                  data: userNumbers["hosted"],
                ),
                UserNumberData(
                  color: widget.color,
                  title: "Attended",
                  data: userNumbers["attended"],
                ),
                UserNumberData(
                  color: widget.color,
                  title: "Followers",
                  data: userNumbers["followers"],
                ),
                UserNumberData(
                  color: widget.color,
                  title: "Following",
                  data: userNumbers["following"],
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
            Text(
              user?.bio ?? "",
            ),
            SizedBox(
              height: 3.h,
            ),
            !isCurrentUser
                ? CustomButton(
                    title: "Follow",
                    function: () {},
                  )
                : CustomButton(
                    title: "Edit profile",
                    function: () => Navigator.pushNamed(
                      context,
                      "/EditProfileScreen",
                      arguments: {
                        "user": user,
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  void getUserDetails() {
    var userProvider = Provider.of<UsersProvider>(context, listen: false);
    Users userData = userProvider.userData;

    if (userData.id == widget.userId) {
      isCurrentUser = true;
      user = userData;
      userNumbers = userData.getUserNumbersInFormatedString();
    } else {
      user = userProvider.getUser(widget.userId);
      userNumbers = user?.getUserNumbersInFormatedString();
    }
  }
}
