import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../data.dart';
import '../widgets/home_screen_widgets/event_today_tile.dart';
import '../widgets/general_widgets/custom_app_bar.dart';

class SeeAllScreen extends StatelessWidget {
  const SeeAllScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.5.w),
          child: Column(
            children: [
              // some spacing
              SizedBox(
                height: 2.h,
              ),

              // custom app bar
              CustomAppBar(
                title: title,
                bottomPadding: 4.h,
              ),

              // list of events to see
              Expanded(
                  child: ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: event // list of events
                    .map(
                      (e) => EventListTile(data: e), // event today tile
                    )
                    .toList(),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
