import 'package:cruise/screens/see_all_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/home_screen_widgets/event_today_widget.dart';
import '../../widgets/home_screen_widgets/home_screen_app_bar.dart';
import '../../widgets/home_screen_widgets/home_screen_header.dart';
import '../../widgets/home_screen_widgets/near_by_widget.dart';
import '../../widgets/home_screen_widgets/recommend_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // custom sizedbox with height 2% of screen height
    var sizedBox2 = SizedBox(
      height: 2.h,
    );
    // custom sizedbox with height 4% of screen height
    var sizedBox4 = SizedBox(
      height: 4.h,
    );

    return SafeArea(
      child: Column(
        children: [
          // some spacing
          sizedBox2,

          // custom app bar holding app namd and notification bell
          const HomeScreenAppBar(),

          // some spacing
          SizedBox(
            height: 1.h,
          ),

          // expanded widgets for the rest of the home screen widgets
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // reommeded category
                  const HomeScreenHeader(
                    title: "RECOMMENDED",
                    screen: SeeAllScreen(title: "RECOMMENDED"),
                  ),
                  sizedBox2,
                  const RecomndedWidget(),
                  sizedBox4,
                  const HomeScreenHeader(
                    title: "NEARBY",
                    screen: SeeAllScreen(title: "NEARBY"),
                  ),
                  sizedBox2,
                  const NearByWidget(),
                  sizedBox4,
                  const HomeScreenHeader(
                    title: "TODAY",
                    screen: SeeAllScreen(title: "TODAY"),
                  ),
                  sizedBox2,
                  const EventTodayWidget(),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
