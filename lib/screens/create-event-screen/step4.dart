import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/event_screen_widgets/event_screen_title_widget.dart';

class Step4 extends StatefulWidget {
  const Step4({
    super.key,
    required this.getFunction,
  });

  final Function(List<Map<String, dynamic>>) getFunction;

  @override
  State<Step4> createState() => _Step4State();
}

class _Step4State extends State<Step4> {
  String? selectedDate;
  String? selectedTime;

  List<Map<String, dynamic>> dateTime = [];

  @override
  Widget build(BuildContext context) {
    var selectedStyle = TextStyle(
      fontSize: 14.sp,
    );
    var sizedBox2 = SizedBox(
      height: 2.h,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const EventScreenTitleWidget(title: "Date & Time"),
        SizedBox(
          height: 5.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const EventScreenTitleWidget(title: "Date:"),
            Text(
              selectedDate ?? "No date selected",
              style: selectedStyle,
            ),
          ],
        ),
        sizedBox2,
        ElevatedButton(
          onPressed: () => showDateSelector(context),
          child: const Text("Select date"),
        ),
        SizedBox(
          height: 5.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const EventScreenTitleWidget(title: "Time:"),
            Text(
              selectedTime ?? "No time selected",
              style: selectedStyle,
            ),
          ],
        ),
        sizedBox2,
        ElevatedButton(
          onPressed: () => showTimeSelector(context),
          child: const Text("Select time"),
        ),
      ],
    );
  }

  void showDateSelector(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(3000),
      builder: selectorBuilder,
    );

    if (date != null) {
      setState(() {
        selectedDate = "${date.day}/${date.month}/${date.year}";
        dateTime.add(
          {"date": date},
        );
      });
    }
    widget.getFunction(dateTime);
  }

  void showTimeSelector(BuildContext context) async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: selectorBuilder,
    );

    setState(() {
      selectedTime = "${time?.hour}:${time?.minute} ${time?.period.name}";
      dateTime.add(
        {"time": time},
      );
    });
    widget.getFunction(dateTime);
  }

  Theme selectorBuilder(BuildContext context, child) {
    var of = Theme.of(context);
    var primaryColor = of.primaryColor;
    return Theme(
      data: ThemeData(
          colorScheme: ColorScheme.light(
        primary: primaryColor,
      )),
      child: child!,
    );
  }
}
