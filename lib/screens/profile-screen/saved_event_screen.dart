import 'package:cruise/widgets/general_widgets/shimmer_loading_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/event.dart';
import '../../providers/event_provider.dart';
import '../../providers/users_provider.dart';
import '../../widgets/general_widgets/custom_app_bar.dart';
import '../../widgets/general_widgets/empty_list_widget.dart';
import '../../widgets/home_screen_widgets/rec_event_tile.dart';

class SavedEventScreen extends StatelessWidget {
  static const routeName = "/SavedEventScreen";

  const SavedEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);
    final usersProvider = Provider.of<UsersProvider>(context);

    return Scaffold(
      appBar: const CustomAppBar(title: "Saved"),
      body: usersProvider.saved.isEmpty
          ? const EmptyListWidget(
              title: "No saved events yet",
              subTitle: 'Explore events and save your favorites!',
            )
          : ListView(
              children: usersProvider.saved.map((e) {
                return FutureBuilder(
                    future: eventProvider.getEvent(e),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const SizedBox();
                      }

                      if (snapshot.hasData && !snapshot.data!.exists) {
                        return const SizedBox();
                      }

                      if (snapshot.connectionState == ConnectionState.done) {
                        Map<String, dynamic> data =
                            snapshot.data?.data() as Map<String, dynamic>;

                        Event event = Event.fromJson(data);

                        return RecEventTile(
                          fromSave: true,
                          event: event,
                        );
                      }

                      return const ShimmerLoadingTile();
                    });
              }).toList(),
            ),
    );
  }
}
