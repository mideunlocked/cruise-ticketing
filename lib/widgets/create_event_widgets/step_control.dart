import 'package:flutter/material.dart';

class StepControl extends StatelessWidget {
  const StepControl({
    super.key,
    required this.title,
    required this.function,
  });

  final String title;
  final Function function;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var primaryColor = of.primaryColor;

    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
          primaryColor.withOpacity(0.2),
        ),
      ),
      onPressed: () {
        function();
      },
      child: Text(
        title,
        style: of.textTheme.bodyMedium?.copyWith(color: primaryColor),
      ),
    );
  }
}
