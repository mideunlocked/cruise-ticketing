import 'dart:io';

import 'package:flutter/material.dart';

import '../../pages/sign-up/sign_up_page_1.dart';
import '../../pages/sign-up/sign_up_page_2.dart';
import '../../pages/sign-up/sign_up_page_3.dart';
import '../../pages/sign-up/sign_up_page_4.dart';
import '../../pages/sign-up/sign_up_page_5.dart';
import '../../pages/sign-up/sign_up_page_6.dart';
import '../../widgets/auth_widgets/sign-up-widgets/completing_dialog.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = "/SignUpScreen";

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final pageController = PageController();

  final fullNameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final bioController = TextEditingController();
  final numberController = TextEditingController();
  final passwordController = TextEditingController();

  final fullNameNode = FocusNode();
  final usernameNode = FocusNode();
  final emailNode = FocusNode();
  final bioNode = FocusNode();
  final numberNode = FocusNode();
  final passwordNode = FocusNode();

  File file = File("");

  String userGender = "Prefer not to say";

  DateTime db = DateTime.now();
  String? dateOfBirth;

  @override
  void initState() {
    super.initState();

    dateOfBirth = "${db.day}/${db.month}/${db.year}";
  }

  @override
  void dispose() {
    super.dispose();

    pageController.dispose();

    fullNameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    bioController.dispose();
    numberController.dispose();
    passwordController.dispose();

    fullNameNode.dispose();
    usernameNode.dispose();
    emailNode.dispose();
    bioNode.dispose();
    numberNode.dispose();
    passwordNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            SignUpPage1(
              pageController: pageController,
              fullNameController: fullNameController,
              fullNameNode: fullNameNode,
              usernameController: usernameController,
              usernameNode: usernameNode,
              emailController: emailController,
              emailNode: emailNode,
              passwordController: passwordController,
              passwordNode: passwordNode,
              function: () {},
            ),
            SignUpPage2(
              pageController: pageController,
              getImage: getImageFile,
              imageFile: file,
            ),
            SingUpPage3(
              pageController: pageController,
              bioController: bioController,
              bioNode: bioNode,
            ),
            SingUpPage4(
              pageController: pageController,
              numberController: numberController,
              numberNode: numberNode,
            ),
            SignUpPage5(
              pageController: pageController,
              userGender: userGender,
              getUserGender: getUserGender,
            ),
            SignUpPage6(
              dateOfBirth: dateOfBirth ?? "",
              pageController: pageController,
              getDateOfBirth: getUserDateOfBirth,
              function: showCompletingDialog,
            ),
          ],
        ),
      ),
    );
  }

  void getUserDateOfBirth(String newDOB) {
    setState(() {
      dateOfBirth = newDOB;
    });
  }

  void getUserGender(String newGender) {
    setState(() {
      userGender = newGender;
    });
  }

  void getImageFile(File imageFile) {
    setState(() {
      file = imageFile;
    });
  }

  void showCompletingDialog() {
    showDialog(
      context: context,
      builder: (ctx) => const CompletingDialog(),
    );
  }
}
