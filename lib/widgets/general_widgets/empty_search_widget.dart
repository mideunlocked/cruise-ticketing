import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class EmptySearchWidget extends StatelessWidget {
  const EmptySearchWidget({
    super.key,
    required this.searchKeyWord,
  });

  final String searchKeyWord;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        children: [
          LottieBuilder.asset(
            "assets/lottie/search_empty.json",
            width: 70.w,
            height: 40.h,
          ),
          Text(
            "'$searchKeyWord' not found",
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          const Text(
            "Sorry the keyoword you entered cannot be found please check again or search with another keyword",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
