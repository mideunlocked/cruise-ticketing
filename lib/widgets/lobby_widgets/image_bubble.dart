import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../models/users.dart';
import '../general_widgets/profile_image.dart';

class ImageBubble extends StatelessWidget {
  const ImageBubble({
    super.key,
    required this.paddingInsets,
    required this.user,
  });

  final EdgeInsets paddingInsets;
  final Users? user;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Padding(
          padding: paddingInsets.copyWith(left: 0, top: 0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              "https://images.pexels.com/photos/2147029/pexels-photo-2147029.jpeg?auto=compress&cs=tinysrgb&w=600",
              width: 35.w,
              height: 25.h,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 1.w, bottom: 2.h),
          child: ProfileImage(
            userId: user?.id ?? "",
            imageUrl: user?.imageUrl ?? "",
            radius: 20.sp,
          ),
        ),
      ],
    );
  }
}
