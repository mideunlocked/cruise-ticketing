import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    super.key,
    required this.function,
    required this.heroTag,
    required this.iconUrl,
  });

  final Function function;
  final String heroTag;
  final String iconUrl;

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.6), // Glow color
            blurRadius: 20.0, // Spread of the glow
            spreadRadius: 2.0, // Spread radius
          ),
        ],
      ),
      child: FloatingActionButton(
        backgroundColor: primaryColor,
        heroTag: heroTag,
        onPressed: () {
          function();
        },
        child: Image.asset(
          "assets/icons/$iconUrl.png",
          height: 8.h,
          width: 8.w,
          color: Colors.white,
        ),
      ),
    );
  }
}
