import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/edit_profile_widgets/custom_text_field.dart';
import '../../widgets/auth_widgets/sign-up-widgets/sign_up_continue.dart';
import '../../widgets/auth_widgets/sign-up-widgets/sign_up_page_header.dart';
import '../../widgets/auth_widgets/sign-up-widgets/sign_up_skip_button.dart';

class SingUpPage3 extends StatelessWidget {
  const SingUpPage3({
    super.key,
    required this.bioController,
    required this.pageController,
    required this.bioNode,
  });

  final TextEditingController bioController;
  final PageController pageController;
  final FocusNode bioNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SignUpSkipButton(),
            const SignUpPageHeader(
              title: "Bio",
              subTitle:
                  "Share a few words that describe who you are and your interests.",
            ),
            SizedBox(height: 3.h),
            CustomTextField(
              controller: bioController,
              focusNode: bioNode,
              label: "Bio",
              maxLines: 5,
              maxText: 300,
            ),
            SizedBox(height: 10.h),
            SignUpContinueButton(
              heroTag: "Sign up 3",
              function: () {
                pageController.nextPage(
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
