import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/snack_bar_widget.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/auth_widgets/auth_button.dart';
import '../../widgets/edit_profile_widgets/custom_text_field.dart';
import '../../widgets/general_widgets/indisimissible_loading_indicator.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = "/ForgotPasswordScreen";

  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();

  final emailNode = FocusNode();

  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void dispose() {
    super.dispose();

    emailController.dispose();
    emailNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 1.h),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: LottieBuilder.asset(
                              "assets/lottie/forgot-password.json",
                              height: 30.h,
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            "Forgot Password",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 20.sp,
                            ),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          CustomTextField(
                            controller: emailController,
                            focusNode: emailNode,
                            label: "Email",
                            inputType: TextInputType.emailAddress,
                            inputAction: TextInputAction.send,
                            isRequired: true,
                          ),
                          SizedBox(height: 5.h),
                          AuthButton(
                            title: "Send password reset",
                            function: sendPasswordReset,
                          ),
                          SizedBox(height: 10.h),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void sendPasswordReset() async {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);

    final isValid = _formKey.currentState!.validate();
    if (isValid == false) {
      return;
    } else {
      showLoadingIndicator();

      final response =
          await authProvider.resetPassword(emailController.text.trim());

      if (response == true) {
        if (mounted) {
          Navigator.pop(context);
        }

        CustomSnackBar.showCustomSnackBar(
          _scaffoldKey,
          "Password reset email sent. Check your inbox.",
          color: Colors.green,
        );
      } else {
        if (mounted) {
          Navigator.pop(context);
        }

        CustomSnackBar.showCustomSnackBar(
          _scaffoldKey,
          response,
        );
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
