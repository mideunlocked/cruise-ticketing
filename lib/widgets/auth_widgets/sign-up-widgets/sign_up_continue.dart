import 'package:flutter/material.dart';

import '../../general_widgets/custom_floating_action_button.dart';

class SignUpContinueButton extends StatelessWidget {
  const SignUpContinueButton({
    super.key,
    required this.heroTag,
    required this.function,
    this.isLast = false,
  });

  final bool isLast;
  final Function function;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomFloatingActionButton(
          function: () => function(),
          heroTag: heroTag,
          iconUrl: "",
          icon: isLast ? Icons.done_rounded : Icons.arrow_forward_rounded,
        )
      ],
    );
  }
}
