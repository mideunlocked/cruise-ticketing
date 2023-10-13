import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.focusNode,
    this.inputType = TextInputType.name,
    this.inputAction = TextInputAction.next,
    this.maxLines,
    this.maxText,
  });

  final String label;
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final int? maxLines;
  final int? maxText;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var primaryColor = of.primaryColor;
    var bodyMedium = textTheme.bodyMedium;

    var outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(
        color: Colors.black,
      ),
    );

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 2.h,
      ),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        style: bodyMedium,
        cursorColor: primaryColor,
        textInputAction: inputAction,
        keyboardType: inputType,
        maxLength: maxText,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: outlineInputBorder,
          enabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          labelStyle: bodyMedium?.copyWith(
            fontSize: 12.sp,
          ),
          hintStyle: bodyMedium?.copyWith(
            color: Colors.black26,
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "This field can't be empty";
          }
          return null;
        },
      ),
    );
  }
}
