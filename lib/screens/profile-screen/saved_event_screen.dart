import 'package:cruise/widgets/home_screen_widgets/rec_event_tile.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../data.dart';
import '../../widgets/general_widgets/custom_app_bar.dart';

class SavedEventScreen extends StatelessWidget {
  static const routeName = "/SavedEventScreen";

  const SavedEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 3.w,
              ),
              child: CustomAppBar(
                title: "Saved",
                bottomPadding: 1.h,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: event.length,
                itemBuilder: (ctx, index) => event[index]["isSaved"] == true
                    ? RecEventTile(
                        fromSave: true,
                        data: event[index],
                      )
                    : const SizedBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
