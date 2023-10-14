import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/event_screen_widgets/event_screen_title_widget.dart';

class Step7 extends StatefulWidget {
  const Step7({
    super.key,
    required this.getFunction,
  });

  final Function(bool) getFunction;

  @override
  State<Step7> createState() => _Step5State();
}

class _Step5State extends State<Step7> {
  bool isPublic = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const EventScreenTitleWidget(title: "Privacy and visibility"),
        SizedBox(
          height: 5.h,
        ),
        Row(
          children: [
            SizedBox(
              width: 70.w,
              child: const Text(
                  "Is the event intended for public access, open to everyone?"),
            ),
            Switch(
              value: isPublic,
              onChanged: (value) {
                setState(() {
                  isPublic = value;
                });
                widget.getFunction(isPublic);
              },
              activeColor: Colors.black,
              inactiveTrackColor: Colors.grey,
            ),
          ],
        ),
      ],
    );
  }
}
