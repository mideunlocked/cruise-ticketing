import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../data.dart';
import '../../providers/event_provider.dart';
import '../../widgets/general_widgets/custom_app_bar.dart';
import '../../widgets/home_screen_widgets/rec_event_tile.dart';

class SavedEventScreen extends StatelessWidget {
  static const routeName = "/SavedEventScreen";

  const SavedEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);

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
                itemBuilder: (ctx, index) => RecEventTile(
                  fromSave: true,
                  event: eventProvider.events.first,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
