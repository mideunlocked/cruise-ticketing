import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../models/users.dart';
import '../../screens/followers_following_screen.dart';
import '../general_widgets/custom_button.dart';
import '../general_widgets/profile_image.dart';
import 'user_number_data.dart';

class UserDetailCard extends StatefulWidget {
  const UserDetailCard({
    super.key,
    required this.of,
    required this.color,
    required this.user,
  });

  final ThemeData of;
  final Color? color;
  final Users? user;

  @override
  State<UserDetailCard> createState() => _UserDetailCardState();
}

class _UserDetailCardState extends State<UserDetailCard> {
  dynamic userNumbers;
  bool isCurrentUser = false;

  @override
  void initState() {
    super.initState();

    userNumbers = widget.user?.getUserNumbersInFormatedString() ?? {};
    isCurrentUser = widget.user?.id == FirebaseAuth.instance.currentUser?.uid;
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
                imageUrl: widget.user?.imageUrl ?? "",
                radius: 70.0,
                isAuthUser: true,
                userId: widget.user?.id ?? "",
              ),
            ),
            Text(
              widget.user?.name ?? "",
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "@${widget.user?.username ?? ""}",
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
                  data: userNumbers["hosted"] ?? "",
                ),
                UserNumberData(
                  color: widget.color,
                  title: "Attended",
                  data: userNumbers["attended"] ?? "",
                ),
                InkWell(
                  onTap: () {
                    navigateToFollowersFollowing(widget.user);
                  },
                  child: UserNumberData(
                    color: widget.color,
                    title: "Followers",
                    data: userNumbers["followers"] ?? "",
                  ),
                ),
                InkWell(
                  onTap: () {
                    navigateToFollowersFollowing(widget.user);
                  },
                  child: UserNumberData(
                    color: widget.color,
                    title: "Following",
                    data: userNumbers["following"] ?? "",
                  ),
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
              widget.user?.bio ?? "",
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
                        "user": widget.user,
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  void navigateToFollowersFollowing(Users? user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => FollowersFollowingScreen(user: user),
      ),
    );
  }
}
