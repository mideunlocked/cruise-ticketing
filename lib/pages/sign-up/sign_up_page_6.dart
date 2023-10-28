import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/create_event_widgets/text_field_title.dart';
import '../../widgets/edit_profile_widgets/profile_input_container.dart';
import '../../widgets/auth_widgets/sign-up-widgets/sign_up_continue.dart';
import '../../widgets/auth_widgets/sign-up-widgets/sign_up_page_header.dart';
import '../../widgets/auth_widgets/sign-up-widgets/sign_up_skip_button.dart';

class SignUpPage6 extends StatefulWidget {
  const SignUpPage6({
    super.key,
    required this.getDateOfBirth,
    required this.pageController,
    required this.dateOfBirth,
    required this.function,
  });

  final Function(String) getDateOfBirth;
  final Function function;
  final PageController pageController;
  final String dateOfBirth;

  @override
  State<SignUpPage6> createState() => _SignUpPage6State();
}

class _SignUpPage6State extends State<SignUpPage6> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SignUpSkipButton(),
          const SignUpPageHeader(
            title: "Date of birth",
            subTitle:
                "This helps us celebrate your special day and tailor our services to your preferences.",
          ),
          SizedBox(height: 6.h),
          const TextFieldTitle(title: "Date of birth"),
          InkWell(
            onTap: () => showBirthdayPicker(),
            child: ProfileInputContainer(
              child: Text(widget.dateOfBirth),
            ),
          ),
          SizedBox(height: 10.h),
          SignUpContinueButton(
            heroTag: "Sign up 6",
            isLast: true,
            function: () => widget.function(),
          ),
        ],
      ),
    );
  }

  void showBirthdayPicker() async {
    var db = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900, 1, 1),
        lastDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.year,
        builder: (BuildContext context, child) {
          var of = Theme.of(context);
          var primaryColor = of.primaryColor;
          return Theme(
            data: ThemeData(
                colorScheme: ColorScheme.light(
              primary: primaryColor,
            )),
            child: child!,
          );
        });

    if (db != null) {
      setState(() {
        final selectedDate = "${db.day}/${db.month}/${db.year}";
        widget.getDateOfBirth(selectedDate);
      });
    }
  }
}
