import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TicketWidgetPadding extends StatelessWidget {
  const TicketWidgetPadding({
    super.key,
    required this.child,
    required this.horizontalPadding,
  });

  final Widget child;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: horizontalPadding,
        right: horizontalPadding,
        top: 1.h,
      ),
      child: child,
    );
  }
}
