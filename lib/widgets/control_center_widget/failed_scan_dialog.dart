import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:lottie/lottie.dart';

import '../general_widgets/custom_button.dart';

class FailedScanDialog extends StatelessWidget {
  const FailedScanDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 15.h,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 7.w,
          vertical: 2.h,
        ),
        child: Column(
          children: [
            LottieBuilder.asset(
              "assets/lottie/failed.json",
              width: 60.w,
              height: 30.h,
              fit: BoxFit.cover,
            ),
            const Spacer(),
            const Text(
              "Invalid validation",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            const Text(
              "Regrettably, no attendee has been identified for this ticket. We kindly request you to carefully review the ticket for any potential fraudulent activity and attempt the process once again. Thank you for your understanding and cooperation.",
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 2.h,
            ),
            CustomButton(
              title: "Okay",
              function: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
