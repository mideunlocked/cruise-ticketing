import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TabWidget extends StatelessWidget {
  const TabWidget({
    super.key,
    required this.title,
    required this.check,
    required this.toggleTab,
  });

  final Function toggleTab;
  final String title;
  final bool check;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var primaryColor = of.primaryColor;
    return InkWell(
      onTap: () => toggleTab(),
      child: Container(
        height: double.infinity,
        width: 46.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // changes UI acccording to device theme mode and if tab is currently selected
          color: check == true
              ? MediaQuery.platformBrightnessOf(context) == Brightness.light
                  ? Colors.black
                  : primaryColor
              : Colors.transparent,
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: check == true ? Colors.white : null,
          ),
        ),
      ),
    );
  }
}
