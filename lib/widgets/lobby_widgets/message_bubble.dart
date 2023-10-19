import 'dart:ui';

import 'package:cruise/helpers/date_time_formatting.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/message.dart';
import '../../models/users.dart';
import '../../providers/users_provider.dart';
import 'bubble.dart';
import 'image_bubble.dart';
import 'reply_bubble.dart';

class MessageBubble extends StatefulWidget {
  const MessageBubble({
    super.key,
    required this.message,
    required this.scrollController,
  });

  final Message message;
  final ScrollController scrollController;

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  Users? user;

  @override
  void initState() {
    super.initState();

    user = getUser();
  }

  @override
  Widget build(BuildContext context) {
    var checkIsMe = widget.message.checkIsMe();

    var paddingInsets = EdgeInsets.symmetric(
      horizontal: 4.w,
      vertical: 1.h,
    );

    Alignment alignment =
        checkIsMe ? Alignment.centerRight : Alignment.centerLeft;

    return Align(
      alignment: alignment,
      child: Column(
        crossAxisAlignment:
            checkIsMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: widget.message.reply?.messageId.isNotEmpty ?? false,
            child: ReplyBubble(
              paddingInsets: paddingInsets,
              message: widget.message,
              checkIsMe: checkIsMe,
              scrollController: widget.scrollController,
            ),
          ),
          InkWell(
            onLongPress: () => bubbleActionDialog(),
            onDoubleTap: () => bubbleActionDialog(),
            child: SizedBox(
              child: widget.message.fileLink.isNotEmpty
                  ? ImageBubble(paddingInsets: paddingInsets, user: user)
                  : Bubble(
                      paddingInsets: paddingInsets,
                      checkIsMe: checkIsMe,
                      message: widget.message,
                      user: user,
                    ),
            ),
          )
        ],
      ),
    );
  }

  Users getUser() {
    var userProvider = Provider.of<UsersProvider>(context, listen: false);

    return userProvider.getUser(widget.message.userId);
  }

  void bubbleActionDialog() {
    showDialog(
      context: context,
      builder: (ctx) => BubbleActionDIalog(
        message: widget.message,
      ),
    );
  }
}

class BubbleActionDIalog extends StatefulWidget {
  const BubbleActionDIalog({
    super.key,
    required this.message,
  });

  final Message message;

  @override
  State<BubbleActionDIalog> createState() => _BubbleActionDIalogState();
}

class _BubbleActionDIalogState extends State<BubbleActionDIalog> {
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

class BubbleActionTile extends StatelessWidget {
  const BubbleActionTile({
    super.key,
    required this.title,
    this.icon,
    required this.function,
    this.withIcon = true,
  });

  final String title;
  final bool withIcon;
  final IconData? icon;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontFamily: "Poppins",
          fontSize: 10.sp,
        ),
      ),
      trailing: withIcon
          ? Icon(
              icon,
              color: Colors.black,
            )
          : null,
      onTap: () => function(),
    );
  }
}
