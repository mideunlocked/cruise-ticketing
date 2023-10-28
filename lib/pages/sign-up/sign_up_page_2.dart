import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/auth_widgets/sign-up-widgets/sign_up_continue.dart';
import '../../widgets/auth_widgets/sign-up-widgets/sign_up_page_header.dart';
import '../../widgets/auth_widgets/sign-up-widgets/sign_up_skip_button.dart';
import '../../widgets/lobby_widgets/file_picker_widget.dart';

class SignUpPage2 extends StatelessWidget {
  const SignUpPage2({
    super.key,
    required this.getImage,
    required this.pageController,
    required this.imageFile,
  });

  final File imageFile;
  final Function(File) getImage;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        children: [
          const SignUpSkipButton(),
          const SignUpPageHeader(
            title: "Profile picture",
            subTitle:
                "Kindly upload your profile picture or capture a new one using CRUISE.",
          ),
          SizedBox(height: 18.h),
          InkWell(
            onTap: () => showFilePicker(context),
            borderRadius: BorderRadius.circular(50),
            child: imageFile.existsSync()
                ? CircleAvatar(
                    radius: 70.sp,
                    foregroundImage: FileImage(imageFile),
                  )
                : Container(
                    height: 20.h,
                    width: 50.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade200,
                    ),
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/icons/camera.png",
                      height: 15.h,
                      width: 15.w,
                    ),
                  ),
          ),
          SizedBox(height: 10.h),
          SignUpContinueButton(
            heroTag: "Sign up 2",
            function: () {
              pageController.nextPage(
                duration: const Duration(seconds: 1),
                curve: Curves.fastLinearToSlowEaseIn,
              );
            },
          ),
        ],
      ),
    );
  }

  void showFilePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => FilePickerWidget(
        lobbyId: "",
        getFile: getImage,
      ),
    );
  }
}
