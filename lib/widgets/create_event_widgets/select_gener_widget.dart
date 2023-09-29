import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../data.dart';
import 'text_field_title.dart';

class SelectGenerWidget extends StatefulWidget {
  const SelectGenerWidget({
    super.key,
  });

  @override
  State<SelectGenerWidget> createState() => _SelectGenerWidgetState();
}

class _SelectGenerWidgetState extends State<SelectGenerWidget> {
  String gener = eventCategoryNames[0];

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var bodyMedium = textTheme.bodyMedium;

    // bool checkMode =
    //     MediaQuery.platformBrightnessOf(context) == Brightness.light;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextFieldTitle(
          title: "GENER",
        ),
        Container(
          height: 7.h,
          decoration: BoxDecoration(
            color: of.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: DropdownButton(
            value: gener,
            isExpanded: true,
            borderRadius: BorderRadius.circular(20),
            hint: Text(
              "Choose the Gener of Event",
              style: bodyMedium?.copyWith(
                color: Colors.black26,
              ),
            ),
            style: bodyMedium,
            underline: const SizedBox(),
            menuMaxHeight: 75.h,
            items: eventCategoryNames
                .map(
                  (category) => DropdownMenuItem(
                    value: category,
                    child: Text(
                      category,
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                gener = value!.trim().toString();
              });
            },
          ),
        ),
      ],
    );
  }
}
