import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/auth_widgets/contiue_with_widget.dart';
import '../../widgets/auth_widgets/sign-up-widgets/sign_up_continue.dart';
import '../../widgets/auth_widgets/sign-up-widgets/sign_up_page_header.dart';
import '../../widgets/edit_profile_widgets/custom_text_field.dart';
import '../../widgets/general_widgets/custom_app_bar.dart';

class SignUpPage1 extends StatelessWidget {
  const SignUpPage1({
    super.key,
    required this.pageController,
    required this.fullNameController,
    required this.fullNameNode,
    required this.usernameController,
    required this.usernameNode,
    required this.emailController,
    required this.emailNode,
    required this.passwordController,
    required this.passwordNode,
    required this.function,
  });

  final PageController pageController;
  final TextEditingController fullNameController;
  final FocusNode fullNameNode;
  final TextEditingController usernameController;
  final FocusNode usernameNode;
  final TextEditingController emailController;
  final FocusNode emailNode;
  final TextEditingController passwordController;
  final FocusNode passwordNode;
  final Function function;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var bodyMedium = textTheme.bodyMedium;

    return SingleChildScrollView(
      child: Column(
        children: [
          CustomAppBar(
            bottomPadding: 1.h,
            title: "",
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SignUpPageHeader(
                      title: "Sign up",
                      subTitle: "Please Create Your Account Here",
                    ),
                    SizedBox(height: 3.h),
                    CustomTextField(
                      controller: fullNameController,
                      focusNode: fullNameNode,
                      label: "Fullname",
                      isRequired: true,
                    ),
                    CustomTextField(
                      label: "Username",
                      controller: usernameController,
                      focusNode: usernameNode,
                      isRequired: true,
                    ),
                    CustomTextField(
                      label: "Email",
                      controller: emailController,
                      focusNode: emailNode,
                      inputType: TextInputType.emailAddress,
                      isRequired: true,
                    ),
                    CustomTextField(
                      label: "Password",
                      controller: passwordController,
                      focusNode: passwordNode,
                      inputAction: TextInputAction.done,
                      maxLines: 1,
                      isPassword: true,
                      isRequired: true,
                    ),
                    SizedBox(height: 5.h),
                    SignUpContinueButton(
                      heroTag: "Sign up 1",
                      function: () {
                        function();
                        pageController.nextPage(
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      },
                    ),
                    ContinueWithWidget(bodyMedium: bodyMedium),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "I have an account, ",
                            style: bodyMedium?.copyWith(
                              color: Colors.black45,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "Sign in",
                                  style: bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      Navigator.pushNamed(
                                          context, "/SignUpScreen");
                                    }),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
