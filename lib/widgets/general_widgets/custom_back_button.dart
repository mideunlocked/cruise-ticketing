import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 5.h,
      child: FloatingActionButton(
        heroTag: "back-button",
        backgroundColor: Colors.black45,
        onPressed: () => Navigator.pop(context),
        child: const Icon(
          Icons.arrow_back_ios_new_rounded,
        ),
      ),
    );
  }
}
