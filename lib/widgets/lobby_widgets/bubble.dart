import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../models/users.dart';
import '../../screens/user_profile_screen.dart';
import 'message_bubble.dart';

class Bubble extends StatelessWidget {
  const Bubble({
    super.key,
    required this.marginInsets,
    required this.paddingInsets,
    required this.checkIsMe,
    required this.widget,
    required this.user,
  });

  final EdgeInsets marginInsets;
  final EdgeInsets paddingInsets;
  final bool checkIsMe;
  final MessageBubble widget;
  final Users? user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: marginInsets.copyWith(top: 0, bottom: 0.5.h),
      padding: paddingInsets,
      decoration: BoxDecoration(
        color: checkIsMe
            ? Theme.of(context).primaryColor.withOpacity(0.8)
            : Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: widget.message.userId != "0",
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => UserProfileScreen(userId: user?.id ?? ""),
                  ),
                );
              },
              child: Text(
                user?.username ?? "",
                style: TextStyle(
                  color: Colors.red[900],
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.red[900],
                ),
              ),
            ),
          ),
          Text(
            widget.message.text,
            style: TextStyle(
              color: checkIsMe ? Colors.white : null,
            ),
          ),
        ],
      ),
    );
  }
}
