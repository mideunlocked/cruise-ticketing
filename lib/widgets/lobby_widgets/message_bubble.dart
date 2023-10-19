import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/message.dart';
import '../../models/users.dart';
import '../../providers/users_provider.dart';
import 'bubble.dart';
import 'bubble_action_dialog.dart';
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
      builder: (ctx) => BubbleActionDialog(
        message: widget.message,
      ),
    );
  }
}
