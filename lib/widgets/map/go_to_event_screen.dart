import 'package:cruise/screens/event_screens/event_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/users_provider.dart';
import 'locator_event_detail.dart';

class GoToEventScreen extends StatelessWidget {
  const GoToEventScreen({
    super.key,
    required this.widget,
  });

  final LocatorEventDetail widget;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var scaffoldBackgroundColor = of.scaffoldBackgroundColor;

    var userProvider = Provider.of<UsersProvider>(context);

    return FloatingActionButton(
      heroTag: "3",
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (ctx) => FutureBuilder(
                  future: userProvider.getUser(widget.event.hostId),
                  builder: (context, snapshot) {
                    return EventScreen(
                      durationData: widget.duration,
                      event: widget.event,
                      host: snapshot.data,
                    );
                  },
                )),
      ),
      backgroundColor: Colors.grey,
      child: Icon(
        Icons.arrow_forward_ios_rounded,
        color: scaffoldBackgroundColor,
      ),
    );
  }
}
