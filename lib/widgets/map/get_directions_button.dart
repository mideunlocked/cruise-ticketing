import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class GetDirectionsButton extends StatelessWidget {
  const GetDirectionsButton({
    super.key,
    required this.getDirection,
  });

  final Function getDirection;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var primaryColor = of.primaryColor;
    var scaffoldBackgroundColor = of.scaffoldBackgroundColor;

    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(right: 2.w),
        child: FloatingActionButton.extended(
          heroTag: "1",
          backgroundColor: primaryColor,
          onPressed: () => getDirection(),
          label: Text(
            "Get directions",
            style: TextStyle(
              color: scaffoldBackgroundColor,
            ),
          ),
        ),
      ),
    );
  }
}
