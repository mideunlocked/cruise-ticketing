import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../models/users.dart';
import '../pages/followers_following_pages/followers_page.dart';
import '../widgets/followers_following_widgets/followers_following_tab_bar.dart';
import '../widgets/general_widgets/custom_app_bar.dart';

class FollowersFollowingScreen extends StatefulWidget {
  const FollowersFollowingScreen({
    super.key,
    required this.user,
  });

  final Users? user;

  @override
  State<FollowersFollowingScreen> createState() =>
      _FollowersFollowingScreenState();
}

class _FollowersFollowingScreenState extends State<FollowersFollowingScreen> {
  int currentIndex = 0;

  PageController controller = PageController(initialPage: 0);

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var pages = [
      FollowersPage(
        data: widget.user?.followers ?? [],
      ),
      FollowersPage(
        data: widget.user?.following ?? [],
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: widget.user?.username ?? "",
              bottomPadding: 1.h,
            ),
            FollowersFollowingTabBar(
              currentIndex: currentIndex,
              controller: controller,
            ),
            Expanded(
              child: PageView(
                controller: controller,
                children: pages,
                onPageChanged: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
