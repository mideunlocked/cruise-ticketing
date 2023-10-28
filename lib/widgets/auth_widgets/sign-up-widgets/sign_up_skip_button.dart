import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'completing_dialog.dart';

class SignUpSkipButton extends StatelessWidget {
  const SignUpSkipButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var bodyMedium = textTheme.bodyMedium;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(height: 8.h),
        TextButton(
          onPressed: () => showCompletingDialog(context),
          child: Text(
            "Skip",
            style: bodyMedium?.copyWith(
              fontSize: 12.sp,
            ),
          ),
        ),
      ],
    );
  }

  void showCompletingDialog(context) {
    showDialog(
      context: context,
      builder: (ctx) => const CompletingDialog(),
    );
  }
}
