import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/message.dart';
import '../../models/users.dart';
import '../../providers/users_provider.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.message,
  });

  final Message message;

  @override
  Widget build(BuildContext context) {
    var checkIsMe = message.checkIsMe();

    var marginInsets = EdgeInsets.only(
      left: checkIsMe ? 15.w : 0,
      right: checkIsMe ? 0 : 15.w,
      bottom: 2.h,
    );

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
          message.reply?.messageId.isNotEmpty ?? false
              ? ReplyBubble(
                  paddingInsets: paddingInsets,
                  message: message,
                  checkIsMe: checkIsMe,
                )
              : const SizedBox(),
          message.fileLink.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    "https://images.pexels.com/photos/2147029/pexels-photo-2147029.jpeg?auto=compress&cs=tinysrgb&w=600",
                    width: 35.w,
                    height: 25.h,
                    fit: BoxFit.cover,
                  ),
                )
              : Container(
                  margin: marginInsets,
                  padding: paddingInsets,
                  decoration: BoxDecoration(
                    color: checkIsMe
                        ? Theme.of(context).primaryColor
                        : Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      message.userId == "0"
                          ? const SizedBox()
                          : Text(
                              getUser(context).username,
                              style: TextStyle(
                                color: Colors.red[900],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                      Text(
                        message.text,
                        style: TextStyle(
                          color: checkIsMe ? Colors.white : null,
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  Users getUser(BuildContext context) {
    var userProvider = Provider.of<UsersProvider>(context, listen: false);

    return userProvider.getUser(message.userId);
  }
}

class ReplyBubble extends StatelessWidget {
  const ReplyBubble({
    super.key,
    required this.paddingInsets,
    required this.message,
    required this.checkIsMe,
  });

  final EdgeInsets paddingInsets;
  final Message message;
  final bool checkIsMe;

  @override
  Widget build(BuildContext context) {
    var marginInsets = EdgeInsets.only(
      left: checkIsMe ? 25.w : 0,
      right: checkIsMe ? 0 : 25.w,
      bottom: 0.5,
    );

    return message.reply!.fileLink.toString().isNotEmpty
        ? ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              "https://images.pexels.com/photos/2147029/pexels-photo-2147029.jpeg?auto=compress&cs=tinysrgb&w=600",
              width: 35.w,
              height: 25.h,
              fit: BoxFit.cover,
            ),
          )
        : Container(
            margin: marginInsets,
            padding: paddingInsets,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.reply!.messageUserId == "0"
                      ? "You"
                      : getUser(context).username,
                  style: TextStyle(
                    color: Colors.red[200],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  message.reply?.text ?? "",
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.black54),
                ),
              ],
            ),
          );
  }

  Users getUser(BuildContext context) {
    var userProvider = Provider.of<UsersProvider>(context, listen: false);

    return userProvider.getUser(message.reply?.messageUserId ?? "");
  }
}
