import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/create_event_widgets/text_field_title.dart';
import '../../widgets/edit_profile_widgets/profile_input_container.dart';
import '../../widgets/edit_profile_widgets/select_gender_widget.dart';
import '../../widgets/auth_widgets/sign-up-widgets/sign_up_continue.dart';
import '../../widgets/auth_widgets/sign-up-widgets/sign_up_page_header.dart';
import '../../widgets/auth_widgets/sign-up-widgets/sign_up_skip_button.dart';

class SignUpPage5 extends StatefulWidget {
  const SignUpPage5({
    super.key,
    required this.pageController,
    required this.userGender,
    required this.getUserGender,
  });

  final Function(String) getUserGender;
  final PageController pageController;
  final String userGender;

  @override
  State<SignUpPage5> createState() => _SignUpPage5State();
}

class _SignUpPage5State extends State<SignUpPage5> {
  List<String> gender = [
    "Male",
    "Female",
    "Prefer not to say",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SignUpSkipButton(),
          const SignUpPageHeader(
            title: "Gender",
            subTitle:
                "It's an optional detail that can help us provide you with a more personalized experience.",
          ),
          SizedBox(height: 6.h),
          const TextFieldTitle(title: "Gender"),
          ProfileInputContainer(
            child: SelectGenderWidget(
              gender: gender,
              userGender: widget.userGender,
            ),
          ),
          SizedBox(height: 10.h),
          SignUpContinueButton(
            heroTag: "Sign up 5",
            function: () {
              widget.pageController.nextPage(
                duration: const Duration(seconds: 1),
                curve: Curves.fastLinearToSlowEaseIn,
              );
            },
          ),
        ],
      ),
    );
  }
}
