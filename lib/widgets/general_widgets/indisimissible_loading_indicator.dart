import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class UndismissbleLoadingIndicator extends StatelessWidget {
  const UndismissbleLoadingIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          throw 0;
        },
        child: LottieBuilder.asset("assets/lottie/cruise-loader.json"));
  }
}
