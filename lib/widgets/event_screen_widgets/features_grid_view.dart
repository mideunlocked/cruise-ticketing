import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'features_tile_widget.dart';

class FeatureGridView extends StatelessWidget {
  const FeatureGridView({
    super.key,
    required this.features,
  });

  final List features;

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4.w,
        mainAxisSpacing: 4.w,
        mainAxisExtent: 5.h,
      ),
      children: features
          .map(
            // iterates throught the list of features
            (e) => FeaturesTileWidget(
              // features widget which holds the features data
              title: e,
            ),
          )
          .toList(), // convert map iterator to list
    );
  }
}
