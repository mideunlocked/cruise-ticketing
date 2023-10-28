import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/auth_widgets/auth_button.dart';
import '../../widgets/auth_widgets/contiue_with_widget.dart';
import '../../widgets/edit_profile_widgets/custom_text_field.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = "/SignInScreen";

  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final identificationController = TextEditingController();
  final passwordController = TextEditingController();

  final identificationNode = FocusNode();
  final passwordNode = FocusNode();

  @override
  void dispose() {
    super.dispose();

    identificationController.dispose();
    passwordController.dispose();

    identificationNode.dispose();
    passwordNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var bodyMedium = textTheme.bodyMedium;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5.h),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
              Center(
                child: LottieBuilder.asset(
                  "assets/lottie/use-phone.json",
                  height: 30.h,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                "Login to Your Account",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20.sp,
                ),
              ),
              CustomTextField(
                controller: identificationController,
                focusNode: identificationNode,
                label: "Email/Username",
              ),
              CustomTextField(
                controller: passwordController,
                focusNode: passwordNode,
                label: "Password",
                maxLines: 1,
                isPassword: true,
                isRequired: true,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot password?",
                      style: bodyMedium,
                    ),
                  )
                ],
              ),
              SizedBox(height: 3.h),
              AuthButton(
                title: "Sign in",
                function: () {},
              ),
              ContinueWithWidget(bodyMedium: bodyMedium),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
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
                                Navigator.pushNamed(context, "/SignUpScreen");
                              }),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
    );
  }
}
