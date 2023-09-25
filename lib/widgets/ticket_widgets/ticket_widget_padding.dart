import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TicketWidgetPadding extends StatelessWidget {
  const TicketWidgetPadding({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 8.w,
        right: 8.w,
        top: 1.h,
      ),
      child: child,
    );
  }
}
