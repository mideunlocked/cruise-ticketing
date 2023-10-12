import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class ShimmerLoadingTile extends StatelessWidget {
  const ShimmerLoadingTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[200]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 15.h,
            width: 40.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const Column(
          children: [
            TitleShimmer(),
            TitleShimmer(),
            TitleShimmer(),
          ],
        ),
      ],
    );
  }
}

class TitleShimmer extends StatelessWidget {
  const TitleShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 2.w, bottom: 2.h),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[200]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: 2.h,
          width: 50.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
