import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/users.dart';
import '../../providers/users_provider.dart';
import '../../screens/user_profile_screen.dart';
import '../general_widgets/profile_image.dart';

class UserTile extends StatefulWidget {
  const UserTile({
    super.key,
    required this.user,
  });

  final Users user;

  @override
  State<UserTile> createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  bool isFollowing = false;

  @override
  Widget build(BuildContext context) {
    var usersProvider = Provider.of<UsersProvider>(context, listen: false);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => UserProfileScreen(userId: widget.user.id),
          ),
        );
      },
      child: Container(
        height: 20.h,
        width: 85.w,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.only(left: 4.w, right: 1.w),
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
        child: Row(
          children: [
            ProfileImage(
              imageUrl: widget.user.imageUrl,
              radius: 50.sp,
              userId: "1",
              isAuthUser: true,
            ),
            SizedBox(
              width: 5.w,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 30.w,
                  child: Text(
                    widget.user.name,
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 30.w,
                  child: Text(
                    "@${widget.user.username}",
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                usersProvider.userData.id == widget.user.id
                    ? const SizedBox()
                    : Consumer<UsersProvider>(
                        builder: (context, usersProvider, child) {
                        isFollowing =
                            usersProvider.following.contains(widget.user.id);

                        return ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                isFollowing ? Colors.grey[200] : Colors.black),
                          ),
                          onPressed: followUnfollowUser,
                          child: Text(
                            isFollowing ? "Following" : "Follow",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              color: isFollowing ? Colors.black : Colors.white,
                            ),
                          ),
                        );
                      }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void toggleFollow() {
    setState(() {
      isFollowing = !isFollowing;
    });
  }

  void followUnfollowUser() async {
    var usersProvider = Provider.of<UsersProvider>(context, listen: false);
    String userId = widget.user.id;

    if (!usersProvider.following.contains(userId)) {
      await usersProvider.followUser(userId).then((_) => toggleFollow());
    } else {
      await usersProvider.unfollowUser(userId).then((_) => toggleFollow());
    }
  }
}
