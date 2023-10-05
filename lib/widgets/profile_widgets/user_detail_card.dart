import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../general_widgets/custom_button.dart';
import '../general_widgets/profile_image.dart';
import 'user_number_data.dart';

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
              function: () => Navigator.pushNamed(
                context,
                "/EditProfileScreen",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
