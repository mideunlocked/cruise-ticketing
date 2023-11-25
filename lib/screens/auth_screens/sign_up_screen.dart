import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/snack_bar_widget.dart';
import '../../models/users.dart';
import '../../pages/sign-up/sign_up_page_1.dart';
import '../../pages/sign-up/sign_up_page_2.dart';
import '../../pages/sign-up/sign_up_page_3.dart';
import '../../pages/sign-up/sign_up_page_4.dart';
import '../../pages/sign-up/sign_up_page_5.dart';
import '../../pages/sign-up/sign_up_page_6.dart';
import '../../providers/auth_provider.dart';
import '../../providers/image_provider.dart';
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

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
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
                scaffoldKey: _scaffoldKey,
                function: createUserAuth,
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
                dateOfBirth: db,
                pageController: pageController,
                getDateOfBirth: getUserDateOfBirth,
                function: createUserDatabase,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getUserDateOfBirth(DateTime newDOB) {
    setState(() {
      db = newDOB;
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
      barrierDismissible: false,
      builder: (ctx) => const CompletingDialog(),
    );
  }

  void createUserDatabase() async {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    var imageProvider = Provider.of<AppImageProvider>(context, listen: false);

    showCompletingDialog();

    await imageProvider.uploadProfileImage(file);

    final response = await authProvider.createUserInDatabase(
      Users(
        id: "",
        bio: bioController.text.trim(),
        name: fullNameController.text.trim(),
        email: emailController.text.trim(),
        number: numberController.text.trim(),
        gender: userGender,
        hosted: [],
        videoUrl: "",
        username: usernameController.text.trim(),
        imageUrl: "",
        password: passwordController.text.trim(),
        attended: [],
        followers: [],
        following: [],
        highlights: [],
        dateOfBirth: DateTime.now().toString(),
        saved: [],
      ),
    );

    print(response);

    if (response != true) {
      CustomSnackBar.showCustomSnackBar(
        _scaffoldKey,
        response,
      );
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

  Future<dynamic> createUserAuth() async {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);

    final response = await authProvider.createUserEmailAndPassword(
      emailController.text.trim(),
      passwordController.text.trim(),
      fullNameController.text.trim(),
      usernameController.text.trim(),
    );

    return response;
  }
}
