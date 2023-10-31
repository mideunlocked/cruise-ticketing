import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../providers/auth_provider.dart';
import '../general_widgets/indisimissible_loading_indicator.dart';
import 'platform_widget.dart';

class ContinueWithWidget extends StatefulWidget {
  const ContinueWithWidget({
    super.key,
    required this.bodyMedium,
  });

  final TextStyle? bodyMedium;

  @override
  State<ContinueWithWidget> createState() => _ContinueWithWidgetState();
}

class _ContinueWithWidgetState extends State<ContinueWithWidget> {
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);

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
              function: () async {
                showLoadingIndicator();

                final result = await authProvider.googleSignIn(context);

                if (result == false) {
                  if (mounted) {
                    Navigator.pop(context);
                  }
                }
              },
            ),
            PlatformWidget(
              iconUrl: "apple",
              function: () {},
            ),
            PlatformWidget(
              iconUrl: "twitter",
              function: () {},
            ),
          ],
        ),
      ],
    );
  }

  void showLoadingIndicator() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => const UndismissbleLoadingIndicator(),
    );
  }
}
