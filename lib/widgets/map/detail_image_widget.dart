import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../general_widgets/custom_image_error_widget.dart';
import '../general_widgets/custom_loading_indicator.dart';

class DetailImageWidget extends StatelessWidget {
  const DetailImageWidget({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    double imageHeight = 15.h;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        image,
        height: imageHeight,
        width: 35.w,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return CustomLoadingIndicator(
            height: imageHeight,
            width: null,
          );
        },
        errorBuilder: (ctx, _, stacktrace) {
          return SizedBox(
            height: imageHeight,
            child: const CustomImageErrorWidget(),
          );
        },
      ),
    );
  }
}
