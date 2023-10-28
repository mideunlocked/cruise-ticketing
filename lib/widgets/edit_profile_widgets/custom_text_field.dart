import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../create_event_widgets/text_field_title.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.label,
    this.isRequired = true,
    this.isPassword = false,
    this.inputType = TextInputType.name,
    this.inputAction = TextInputAction.next,
    this.maxLines,
    this.maxText,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final String label;
  final bool isRequired;
  final bool isPassword;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final int? maxLines;
  final int? maxText;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    var outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    );

    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var primaryColor = of.primaryColor;
    var bodyMedium = textTheme.bodyMedium;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 2.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFieldTitle(title: widget.label),
          TextFormField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            style: bodyMedium?.copyWith(
              letterSpacing: widget.isPassword ? 3 : null,
              fontSize: widget.isPassword ? 15.sp : null,
            ),
            cursorColor: primaryColor,
            textInputAction: widget.inputAction,
            keyboardType: widget.inputType,
            maxLength: widget.maxText,
            maxLines: widget.maxLines,
            obscureText: widget.isPassword ? isObscure : false,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade200,
                contentPadding: EdgeInsets.symmetric(horizontal: 2.w),
                border: outlineInputBorder,
                enabledBorder: outlineInputBorder,
                focusedBorder: outlineInputBorder,
                hintStyle: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 8.sp,
                  letterSpacing: 0,
                ),
                suffixIcon: Visibility(
                  visible: widget.isPassword,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                    icon: Icon(
                      isObscure
                          ? Icons.visibility_off_rounded
                          : Icons.visibility_rounded,
                    ),
                  ),
                )),
            validator: (value) {
              if (widget.isRequired) {
                if (value!.isEmpty) {
                  return "This field can't be empty";
                }
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
