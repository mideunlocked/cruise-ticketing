import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LobbyTextField extends StatelessWidget {
  const LobbyTextField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    var outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(20),
    );
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var bodyMedium = textTheme.bodyMedium;

    return SizedBox(
      width: 84.w,
      child: TextField(
        controller: controller,
        style: bodyMedium,
        maxLines: 5,
        minLines: 1,
        textInputAction: TextInputAction.newline,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding: EdgeInsets.symmetric(
            horizontal: 2.w,
            vertical: 1.h,
          ),
          border: outlineInputBorder,
          enabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          hintText: 'Message...',
          hintStyle: bodyMedium?.copyWith(
            color: Colors.black45,
          ),
        ),
      ),
    );
  }
}
