import 'package:flutter/material.dart';

class EventScreenTitleWidget extends StatelessWidget {
  const EventScreenTitleWidget({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var primaryColor = of.primaryColor;

    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        // changes UI acccording to device theme mode
        color: MediaQuery.platformBrightnessOf(context) == Brightness.light
            ? Colors.black
            : primaryColor,
      ),
    );
  }
}
