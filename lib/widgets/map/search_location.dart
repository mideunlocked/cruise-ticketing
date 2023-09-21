import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sizer/sizer.dart';

class SearchLocation extends StatefulWidget {
  const SearchLocation({
    super.key,
    required this.controller,
    required this.cameraIsMoving,
  });

  final TextEditingController controller;
  final bool cameraIsMoving;

  @override
  State<SearchLocation> createState() => _SearchLocationState();
}

class _SearchLocationState extends State<SearchLocation> {
  final ValueNotifier<bool> _isVisible = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();

    // Listen to changes in the 'shouldFade' prop and update the visibility accordingly.
    _isVisible.value = widget.cameraIsMoving;
  }

  @override
  void dispose() {
    _isVisible.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var scaffoldBackgroundColor = of.scaffoldBackgroundColor;
    var withOpacity = scaffoldBackgroundColor.withOpacity(0.7);
    var textTheme = of.textTheme;
    var bodyMedium = textTheme.bodyMedium;

    // Use the SchedulerBinding to schedule the visibility change after the current frame.
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _isVisible.value = widget.cameraIsMoving;
    });

    return Positioned(
      bottom: 80.h,
      child: ValueListenableBuilder<bool>(
        valueListenable: _isVisible,
        builder: (context, isVisible, child) {
          return AnimatedOpacity(
            opacity: isVisible ? 0.0 : 1.0,
            duration: const Duration(
                milliseconds: 300), // Adjust the duration as needed.
            child: child,
          );
        },
        child: Container(
          width: 90.w,
          height: 6.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: withOpacity,
          ),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 3.w),
          child: TextField(
            controller: widget.controller,
            style: bodyMedium,
            decoration: InputDecoration(
              hintText: "Search event",
              hintStyle: bodyMedium?.copyWith(color: Colors.white38),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
