import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../general_widgets/custom_back_button.dart';
import '../general_widgets/save_event_button.dart';

class EventImageWidget extends StatelessWidget {
  const EventImageWidget({
    super.key,
    required this.imageUrl,
    required this.isSaved,
  });

  final String imageUrl;
  final bool isSaved;

  @override
  Widget build(BuildContext context) {
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
            height: 65.h,
            width: 100.w,
            fit: BoxFit.cover,
          ),

          // custom back button
          Positioned(
            top: 5.h,
            left: 2.w,
            child: const CustomBackButton(),
          ),

          SaveEventButton(
            isSaved: isSaved,
            top: 5.h,
            left: 85.w,
          ),
        ],
      ),
    );
  }
}
