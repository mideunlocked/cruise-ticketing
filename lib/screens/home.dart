import 'package:cruise/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Home extends StatelessWidget {
  static const routeName = "/";

  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var scaffoldBackgroundColor = of.scaffoldBackgroundColor;
    // var withOpacity = scaffoldBackgroundColor.withOpacity(0.7);
    const radius = Radius.circular(40);
    const borderRadius = BorderRadius.only(
      topLeft: radius,
      topRight: radius,
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          const MapScreen(),
          Material(
            elevation: 30.0,
            borderRadius: borderRadius,
            color: Colors.transparent,
            shadowColor: Colors.white,
            child: Container(
              height: 9.h,
              width: 100.w,
              decoration: BoxDecoration(
                color: scaffoldBackgroundColor,
                borderRadius: borderRadius,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
