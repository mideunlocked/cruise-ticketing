import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'platform_widget.dart';

class ContinueWithWidget extends StatelessWidget {
  const ContinueWithWidget({
    super.key,
    required this.bodyMedium,
  });

  final TextStyle? bodyMedium;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 5.h),
        const Text(
          "or continue with",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PlatformWidget(
              iconUrl: "facebook",
              function: () {},
            ),
            PlatformWidget(
              iconUrl: "google",
              function: () {},
            ),
          ],
        ),
      ],
    );
  }
}
