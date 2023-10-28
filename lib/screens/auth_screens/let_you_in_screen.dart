import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/auth_widgets/auth_button.dart';
import '../../widgets/auth_widgets/custom_divider.dart';
import '../../widgets/auth_widgets/third_party_auth_button.dart';

class LetYouInScreen extends StatefulWidget {
  static const routeName = "/LetYouInScreen";

  const LetYouInScreen({super.key});

  @override
  State<LetYouInScreen> createState() => _LetYouInScreenState();
}

class _LetYouInScreenState extends State<LetYouInScreen> {
  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var bodyMedium = textTheme.bodyMedium;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 7.h),
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
            SizedBox(height: 1.h),
            Center(
              child: LottieBuilder.asset(
                "assets/lottie/partying.json",
                height: 30.h,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Let's you in",
                  style: bodyMedium?.copyWith(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 3.h),
            const ThirdPartyAuthButton(
              iconUrl: "facebook",
              color: Colors.blue,
              title: "Facebook",
            ),
            const ThirdPartyAuthButton(
              iconUrl: "google",
              title: "Google",
            ),
            SizedBox(
              height: 4.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomDivider(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: const Text("or"),
                ),
                const CustomDivider(),
              ],
            ),
            SizedBox(
              height: 4.h,
            ),
            AuthButton(
              title: "Sign in with password",
              function: () => Navigator.pushNamed(context, "/SignInScreen"),
            ),
            SizedBox(
              height: 3.h,
            ),
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
                          text: "Sign up",
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
          ],
        ),
      ),
    );
  }
}
