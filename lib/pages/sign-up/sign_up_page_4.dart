import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/edit_profile_widgets/custom_text_field.dart';
import '../../widgets/auth_widgets/sign-up-widgets/sign_up_continue.dart';
import '../../widgets/auth_widgets/sign-up-widgets/sign_up_page_header.dart';
import '../../widgets/auth_widgets/sign-up-widgets/sign_up_skip_button.dart';

class SingUpPage4 extends StatelessWidget {
  const SingUpPage4({
    super.key,
    required this.numberController,
    required this.pageController,
    required this.numberNode,
  });

  final TextEditingController numberController;
  final PageController pageController;
  final FocusNode numberNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        children: [
          const SignUpSkipButton(),
          const SignUpPageHeader(
            title: "Phone number",
            subTitle:
                "Ensure your profile is complete by providing your contact number. It helps us stay connected with you effectively.",
          ),
          SizedBox(height: 3.h),
          CustomTextField(
            controller: numberController,
            focusNode: numberNode,
            inputType: TextInputType.number,
            label: "Number",
            maxText: 11,
          ),
          SizedBox(height: 10.h),
          SignUpContinueButton(
            heroTag: "Sign up 4",
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
}
