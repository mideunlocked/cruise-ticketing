import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../models/attendee.dart';
import '../../models/users.dart';
import '../general_widgets/profile_image.dart';

class AttendeeTile extends StatelessWidget {
  const AttendeeTile({
    super.key,
    required this.attendee,
    required this.user,
  });

  final Attendee attendee;
  final Users user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 1.h,
        horizontal: 3.w,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileImage(
                imageUrl: user.imageUrl,
                radius: 40.sp,
                userId: attendee.userId,
              ),
              SizedBox(width: 2.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textBox(
                    user.name,
                    fontWeight: FontWeight.bold,
                  ),
                  textBox("@${user.username}"),
                  textBox(user.number),
                  textBox(user.email),
                  textBox(
                    attendee.category,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              const Spacer(),
              Icon(
                attendee.isValidated
                    ? Icons.check_circle_outline_rounded
                    : Icons.circle_outlined,
                color: attendee.isValidated ? Colors.green : Colors.grey,
              ),
            ],
          ),
          const Divider(
            color: Colors.black12,
          ),
        ],
      ),
    );
  }

  SizedBox textBox(
    String text, {
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return SizedBox(
      width: 50.w,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
