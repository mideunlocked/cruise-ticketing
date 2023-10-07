import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class SelectGenderWidget extends StatefulWidget {
  SelectGenderWidget({
    super.key,
    required this.gender,
    required this.userGender,
  });

  late String userGender;
  final List<String> gender;

  @override
  State<SelectGenderWidget> createState() => _SelectGenderWidgetState();
}

class _SelectGenderWidgetState extends State<SelectGenderWidget> {
  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var bodyMedium = textTheme.bodyMedium;

    return DropdownButton(
      value: widget.userGender,
      isExpanded: true,
      borderRadius: BorderRadius.circular(20),
      style: bodyMedium,
      underline: const SizedBox(),
      menuMaxHeight: 75.h,
      items: widget.gender
          .map(
            (gender) => DropdownMenuItem(
              value: gender,
              child: Text(gender),
            ),
          )
          .toList(),
      onChanged: (value) {
        setState(() {
          widget.userGender = value!.trim().toString();
        });
      },
    );
  }
}
