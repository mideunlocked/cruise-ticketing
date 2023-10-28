import 'package:flutter/material.dart';

import '../../models/welcome.dart';
import '../../widgets/auth_widgets/welcome_widget.dart';

class WelcomeScreen extends StatefulWidget {
  static const routeName = "/WelcomeScreen";

  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    super.dispose();

    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: pageController,
        itemCount: welcomeMessages.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (ctx, index) {
          Welcome data = welcomeMessages[index];

          return WelcomeWidget(
            data: data,
            currentIndex: index,
            pageController: pageController,
          );
        },
      ),
    );
  }
}
