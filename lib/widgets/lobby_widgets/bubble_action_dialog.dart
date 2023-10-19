import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/date_time_formatting.dart';
import '../../models/message.dart';
import '../../models/users.dart';
import '../../providers/users_provider.dart';
import 'bubble.dart';
import 'bubble_action_tile.dart';

class BubbleActionDialog extends StatefulWidget {
  const BubbleActionDialog({
    super.key,
    required this.message,
  });

  final Message message;

  @override
  State<BubbleActionDialog> createState() => _BubbleActionDIalogState();
}

class _BubbleActionDIalogState extends State<BubbleActionDialog> {
  Users? user;

  @override
  void initState() {
    super.initState();

    user = getUser();
  }

  @override
  Widget build(BuildContext context) {
    var paddingInsets = EdgeInsets.symmetric(
      horizontal: 4.w,
      vertical: 1.h,
    );

    bool isMe = user?.id == "0";

    String date = DateTimeFormatting.formatDateTime(widget.message.timestamp);
    String time = DateTimeFormatting.formatedTime(widget.message.timestamp);

    return Dialog(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 3.w),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
        child: InkWell(
          onTap: () => Navigator.pop(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Bubble(
                paddingInsets: paddingInsets,
                checkIsMe: isMe,
                message: widget.message,
                user: user,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: EdgeInsets.only(
                  left: isMe ? 60.w : 0,
                  right: isMe ? 0 : 60.w,
                  bottom: 2.h,
                ),
                child: Column(
                  children: [
                    BubbleActionTile(
                      title: date,
                      withIcon: false,
                      function: () {},
                    ),
                    BubbleActionTile(
                      title: time,
                      icon: null,
                      withIcon: false,
                      function: () {},
                    ),
                    BubbleActionTile(
                      title: "Reply",
                      icon: Icons.reply_rounded,
                      function: () {},
                    ),
                    BubbleActionTile(
                      title: "Info",
                      icon: Icons.info_rounded,
                      function: () {},
                    ),
                    BubbleActionTile(
                      title: "Delete",
                      icon: Icons.delete_rounded,
                      function: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Users getUser() {
    var userProvider = Provider.of<UsersProvider>(context, listen: false);

    return userProvider.getUser(widget.message.userId);
  }
}
