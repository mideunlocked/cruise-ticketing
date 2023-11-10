import 'package:cruise/widgets/lobby_widgets/bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../models/message.dart';
import '../../models/users.dart';
import '../general_widgets/profile_image.dart';
import 'view_image_sheet.dart';

class ImageBubble extends StatelessWidget {
  const ImageBubble({
    super.key,
    required this.paddingInsets,
    required this.message,
    required this.user,
  });

  final EdgeInsets paddingInsets;
  final Users? user;
  final Message message;

  @override
  Widget build(BuildContext context) {
    String? uid = FirebaseAuth.instance.currentUser?.uid ?? "";
    var checkIsMe = message.checkIsMe(uid);

    return message.isDeleted
        ? Bubble(
            paddingInsets: paddingInsets,
            checkIsMe: checkIsMe,
            message: message,
            user: user,
          )
        : Stack(
            alignment: Alignment.bottomLeft,
            children: [
              InkWell(
                onTap: () => showImageDialog(context),
                child: Padding(
                  padding: paddingInsets.copyWith(
                    left: 0,
                    top: 0,
                    bottom: 0.5.h,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      message.fileLink,
                      width: 35.w,
                      height: 25.h,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Image.asset(
                          "assets/icons/image.png",
                          width: 35.w,
                          height: 25.h,
                        );
                      },
                      errorBuilder: (BuildContext context, Object error,
                          StackTrace? stackTrace) {
                        return Image.asset(
                          "assets/icons/image.png",
                          width: 35.w,
                          height: 25.h,
                        );
                      },
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: !checkIsMe,
                child: Padding(
                  padding: EdgeInsets.only(left: 1.w, bottom: 2.h),
                  child: ProfileImage(
                    userId: user?.id ?? "",
                    imageUrl: user?.imageUrl ?? "",
                    radius: 20.sp,
                  ),
                ),
              ),
            ],
          );
  }

  void showImageDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => ViewImageSheet(
        message: message,
      ),
    );
  }
}
