import 'package:flutter/material.dart';

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

    return FloatingActionButton(
      heroTag: "3",
      onPressed: () => Navigator.pushNamed(
        context,
        "/EventScreen",
        arguments: widget.data,
      ),
      backgroundColor: Colors.grey,
      child: Icon(
        Icons.arrow_forward_ios_rounded,
        color: scaffoldBackgroundColor,
      ),
    );
  }
}
