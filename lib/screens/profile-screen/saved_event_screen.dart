import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../providers/event_provider.dart';
import '../../widgets/general_widgets/custom_app_bar.dart';
import '../../widgets/general_widgets/empty_list_widget.dart';
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
              child: eventProvider.savedEvents.isEmpty
                  ? const EmptyListWidget(
                      title: "No saved events yet",
                      subTitle: 'Explore events and save your favorites!',
                    )
                  : ListView(
                      children: eventProvider.events
                          .where(
                            (e) => eventProvider.savedEvents.contains(e.id),
                          )
                          .map(
                            (e) => RecEventTile(
                              fromSave: true,
                              event: eventProvider.events.first,
                            ),
                          )
                          .toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
