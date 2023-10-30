import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:lottie/lottie.dart';

import '../../general_widgets/custom_loading_indicator.dart';

class CompletingDialog extends StatelessWidget {
  const CompletingDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        throw 0;
      },
      child: Dialog(
        insetPadding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 12.w),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
                width: 50.w,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    LottieBuilder.asset("assets/lottie/star-shine.json"),
                    LottieBuilder.asset("assets/lottie/verified.json"),
                  ],
                ),
              ),
              Text(
                "Account created!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(height: 1.h),
              const Text(
                "Your account is ready to use. You will be redirected to the Home page in a few seconds",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
              CustomLoadingIndicator(
                height: 15.h,
                width: 100.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
