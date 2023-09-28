import 'package:cruise/screens/bottom_nav/search_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_nav/bottom_nav_bar.dart';
import 'bottom_nav/home_screen.dart';
import 'bottom_nav/map_screen.dart';

class Home extends StatefulWidget {
  static const routeName = "/";

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // the current index of the pagecontroller
  int currentIndex = 2;

  // pageview controller for handling bottom nav bar
  final pageController = PageController(
    initialPage: 2,
  );

  final pages = const [
    HomeScreen(),
    SearchScreen(),
    MapScreen(),
    // Center(
    //   child: Text("Add screen"),
    // ),
    Center(
      child: Text("Profile screen"),
    ),
  ];

  @override
  void dispose() {
    super.dispose();

    // dispose controllers
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // bottom nav screens with page view
          PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (index) => setState(() {
              currentIndex = index;
            }),
            children: pages,
          ),

          // custom bottom nav bar
          BottomNavBar(
            pageController: pageController,
            currentIndex: currentIndex,
          ),
        ],
      ),
    );
  }
}
