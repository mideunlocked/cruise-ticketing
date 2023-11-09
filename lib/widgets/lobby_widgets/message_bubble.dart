import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/message.dart';
import '../../models/reply.dart';
import '../../models/users.dart';
import '../../providers/lobby_provider.dart';
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
    required this.adminId,
    required this.lobbyId,
  });

  final String adminId;
  final String lobbyId;
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

    getUser();
  }

  @override
  Widget build(BuildContext context) {
    var checkIsMe = widget.message.checkIsMe("0");

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
            onLongPress: () =>
                widget.message.isDeleted ? {} : bubbleActionDialog(),
            onDoubleTap: () =>
                widget.message.isDeleted ? {} : passMessageForReply(),
            child: SizedBox(
              child: widget.message.fileLink.isNotEmpty
                  ? ImageBubble(
                      paddingInsets: paddingInsets,
                      message: widget.message,
                      user: user,
                    )
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

  void getUser() async {
    var userProvider = Provider.of<UsersProvider>(context, listen: false);

    user = await userProvider.getUser(widget.message.userId);
  }

  void bubbleActionDialog() {
    showDialog(
      context: context,
      builder: (ctx) => BubbleActionDialog(
        message: widget.message,
        adminId: widget.adminId,
        lobbyId: widget.lobbyId,
      ),
    );
  }

  void passMessageForReply() {
    var lobbyProvider = Provider.of<LobbyProvider>(context, listen: false);

    Message message = widget.message;

    lobbyProvider.addReply(
      Reply(
        text: message.text,
        lobbyId: widget.lobbyId,
        fileLink: message.fileLink,
        messageId: message.id,
        messageUserId: message.userId,
      ),
    );
  }
}
