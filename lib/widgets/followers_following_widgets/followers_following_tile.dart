import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../models/users.dart';
import '../general_widgets/custom_button.dart';
import '../general_widgets/profile_image.dart';

class FollowersFollowingTile extends StatelessWidget {
  const FollowersFollowingTile({
    super.key,
    required this.user,
  });

  final Users user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ProfileImage(
        imageUrl: user.imageUrl,
        radius: 20.sp,
        userId: user.id,
        isAuthUser: false,
      ),
      title: Text(
        user.name,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontFamily: "Poppins",
        ),
      ),
      subtitle: Text(
        "@${user.username}",
        style: const TextStyle(
          color: Colors.black45,
          fontFamily: "Poppins",
        ),
      ),
      trailing: SizedBox(
        width: 18.w,
        height: 6.h,
        child: CustomButton(
          title: "Following",
          function: () {},
          isInactive: true,
        ),
      ),
    );
  }
}
