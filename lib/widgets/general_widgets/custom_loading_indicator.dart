import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({
    super.key,
    required this.height,
    required this.width,
  });

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LottieBuilder.asset(
        "assets/lottie/animation_lnnbyb44.json",
        height: height,
        width: width,
      ),
    );
  }
}
