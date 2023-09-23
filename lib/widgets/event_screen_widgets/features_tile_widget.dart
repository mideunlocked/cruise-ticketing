import 'package:flutter/material.dart';

class FeaturesTileWidget extends StatelessWidget {
  const FeaturesTileWidget({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MediaQuery.platformBrightnessOf(context) ==
                Brightness
                    .light // check and changes UI dynamicaaly according to device theme mode
            ? Colors.black38
            : Colors.white12,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(
        title, // features data
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 2.0,
        ),
      ),
    );
  }
}
