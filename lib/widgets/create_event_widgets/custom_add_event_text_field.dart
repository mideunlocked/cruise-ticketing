import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'text_field_title.dart';

class CustomAddEventTextField extends StatelessWidget {
  const CustomAddEventTextField({
    super.key,
    this.textInputAction = TextInputAction.next,
    required this.controller,
    required this.node,
    required this.hint,
    required this.title,
    this.maxLines = 1,
    this.maxLenght,
  });

  final TextEditingController controller;
  final TextInputAction textInputAction;
  final FocusNode node;
  final String hint;
  final String title;
  final int? maxLenght;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var bodyMedium = textTheme.bodyMedium;
    var primaryColor = of.primaryColor;

    // checks if device is light mode or dark mode
    // bool checkMode =
    //     MediaQuery.platformBrightnessOf(context) == Brightness.light;

    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // custom textfield title
          TextFieldTitle(
            title: title,
          ),
          TextFormField(
            controller: controller,
            focusNode: node,
            maxLength: maxLenght,
            maxLines: maxLines,
            style: bodyMedium,
            textInputAction: TextInputAction.next,
            cursorColor: primaryColor,
            buildCounter: (context,
                    {required currentLength, required isFocused, maxLength}) =>
                maxLenght == null
                    ? const SizedBox()
                    : Text(
                        "$currentLength/$maxLength",
                        style: bodyMedium?.copyWith(
                          fontSize: 8.sp,
                          color: isFocused ? null : Colors.black54,
                        ),
                      ),
            decoration: InputDecoration(
              hintText: hint,
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "This field can't be empty";
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
