import 'package:cruise/screens/map_screen.dart';
import 'package:cruise/widgets/custom_nav/custom_nav.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Home extends StatefulWidget {
  static const routeName = "/";

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // pageview controller for handling bottom nav bar
  PageController pageController = PageController();

  @override
  void dispose() {
    super.dispose();

    // dispose controllers
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var scaffoldBackgroundColor = of.scaffoldBackgroundColor;
    // var withOpacity = scaffoldBackgroundColor.withOpacity(0.7);
    const radius = Radius.circular(40);
    const borderRadius = BorderRadius.only(
      topLeft: radius,
      topRight: radius,
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          const MapScreen(),
          Material(
            elevation: 30.0,
            borderRadius: borderRadius,
            color: Colors.transparent,
            shadowColor: Colors.white,
            child: Container(
              height: 9.h,
              width: 100.w,
              decoration: BoxDecoration(
                color: scaffoldBackgroundColor,
                borderRadius: borderRadius,
              ),
              child: CustomBottomNav(
                pageController: pageController,
                currentIndex: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
