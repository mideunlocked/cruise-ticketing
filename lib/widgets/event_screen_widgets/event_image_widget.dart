import 'package:cruise/widgets/general_widgets/shimmer_loader.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../general_widgets/custom_back_button.dart';
import '../general_widgets/custom_loading_indicator.dart';
import '../general_widgets/save_event_button.dart';

class EventImageWidget extends StatelessWidget {
  const EventImageWidget({
    super.key,
    required this.imageUrl,
    required this.isSaved,
    required this.isInitial,
    required this.eventId,
    required this.isSoldOut,
  });

  final String eventId;
  final String imageUrl;
  final bool isSaved;
  final bool isInitial;
  final bool isSoldOut;

  @override
  Widget build(BuildContext context) {
    double imageHeight = 50.h;

    return ShaderMask(
      shaderCallback: (rect) {
        // adds a linear gradient to the image (makes the bottom shaded)
        return const LinearGradient(
          begin: Alignment.center,
          end: Alignment.bottomCenter,
          colors: [Colors.black, Colors.transparent],
        ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
      },
      blendMode: BlendMode.dstIn,
      child: Stack(
        children: [
          // event image
          Image.network(
            imageUrl,
            height: imageHeight,
            width: 100.w,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return CustomLoadingIndicator(
                height: imageHeight,
                width: null,
              );
            },
            errorBuilder: (ctx, _, stacktrace) {
              return ShimmerLoader(
                height: imageHeight,
              );
            },
          ),

          // sold out animation
          Visibility(
            visible: isSoldOut,
            child: Positioned(
              top: 10.h,
              left: 10.w,
              child: Center(
                child: LottieBuilder.asset(
                  "assets/lottie/sold_out.json",
                  height: 30.h,
                  width: 80.w,
                ),
              ),
            ),
          ),

          // custom back button
          Positioned(
            top: 5.h,
            left: 2.w,
            child: CustomBackButton(
              isInitial: isInitial,
            ),
          ),

          SaveEventButton(
            eventId: eventId,
            isSaved: isSaved,
            top: 5.h,
            left: 85.w,
          ),
        ],
      ),
    );
  }
}
