import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'text_field_icon.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
    required this.primaryColor,
    required this.controller,
    required this.node,
    required this.bodyMedium,
    required this.search,
  });

  final Color primaryColor;
  final TextEditingController controller;
  final FocusNode node;
  final TextStyle? bodyMedium;
  final Function search;

  @override
  Widget build(BuildContext context) {
    // check and changes UI dynamicaaly according to device theme mode
    // bool checkMode =
    //     MediaQuery.platformBrightnessOf(context) == Brightness.light;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: primaryColor.withOpacity(0.1),
      ),
      alignment: Alignment.centerLeft,
      child: TextField(
        controller: controller,
        focusNode: node,
        textInputAction: TextInputAction.search,
        cursorColor: primaryColor,
        style: bodyMedium?.copyWith(
          fontSize: 10.sp,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          hintText: "Search",
          hintStyle: bodyMedium?.copyWith(
            fontSize: 10.sp,
            color: Colors.black26,
          ),
          prefixIcon: const Row(
            children: [
              TextFieldIcon(iconUrl: "assets/icons/search.png"),
            ],
          ),
          suffixIcon: InkWell(
            onTap: () {
              controller.clear();
              search();
            },
            child: SizedBox(
              height: 5.h,
              child: const TextFieldIcon(iconUrl: "assets/icons/close.png"),
            ),
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 5.h,
            maxWidth: 8.w,
          ),
          suffixIconConstraints: BoxConstraints(
            maxHeight: 3.h,
            maxWidth: 3.w,
          ),
        ),
        onChanged: (value) {
          search();
        },
        onSubmitted: (value) {
          search();
          FocusScope.of(context).unfocus();
        },
      ),
    );
  }
}
