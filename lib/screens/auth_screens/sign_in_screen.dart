import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/snack_bar_widget.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/auth_widgets/auth_button.dart';
import '../../widgets/auth_widgets/contiue_with_widget.dart';
import '../../widgets/edit_profile_widgets/custom_text_field.dart';
import '../../widgets/general_widgets/indisimissible_loading_indicator.dart';

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

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  bool isLoading = false;

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

    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 3.h),
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
                          onPressed: () {
                            Navigator.pushNamed(
                                context, "/ForgotPasswordScreen");
                          },
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
                      function: signIn,
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
                                  text: "Sign up",
                                  style: bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      Navigator.pushReplacementNamed(
                                          context, "/SignUpScreen");
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
          ),
        ),
      ),
    );
  }

  void signIn() async {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);

    final isValid = _formKey.currentState!.validate();
    if (isValid == false) {
      return;
    } else {
      showLoadingIndicator();

      final response = await authProvider.signInUSer(
        identificationController.text.trim(),
        passwordController.text.trim(),
      );

      if (response != true) {
        CustomSnackBar.showCustomSnackBar(
          _scaffoldKey,
          response,
        );
        if (mounted) {
          Navigator.pop(context);
        }
      } else {
        if (mounted) {
          Navigator.pop(context);
          Navigator.pushNamedAndRemoveUntil(
            context,
            "/",
            (route) => false,
          );
        }
      }
    }
  }

  void showLoadingIndicator() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => const UndismissbleLoadingIndicator(),
    );
  }
}
