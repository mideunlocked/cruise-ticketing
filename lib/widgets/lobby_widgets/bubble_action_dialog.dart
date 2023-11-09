import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/date_time_formatting.dart';
import '../../models/message.dart';
import '../../models/reply.dart';
import '../../models/users.dart';
import '../../providers/lobby_provider.dart';
import '../../providers/users_provider.dart';
import 'bubble.dart';
import 'bubble_action_tile.dart';

class BubbleActionDialog extends StatefulWidget {
  const BubbleActionDialog({
    super.key,
    required this.message,
    required this.adminId,
    required this.lobbyId,
  });

  final Message message;
  final String adminId;
  final String lobbyId;

  @override
  State<BubbleActionDialog> createState() => _BubbleActionDIalogState();
}

class _BubbleActionDIalogState extends State<BubbleActionDialog> {
  Users? user;

  @override
  void initState() {
    super.initState();

    getUser();
  }

  @override
  Widget build(BuildContext context) {
    var paddingInsets = EdgeInsets.symmetric(
      horizontal: 4.w,
      vertical: 1.h,
    );

    var userProvider = Provider.of<UsersProvider>(context, listen: false);

    bool isMe = user?.id == userProvider.userData.id;

    String date = DateTimeFormatting.formatDateTime(widget.message.dateTime);
    String time = DateTimeFormatting.formatedTime(widget.message.dateTime);

    bool canDelete =
        widget.message.checkIsMe(user?.id ?? "") || user!.id == widget.adminId;

    return Dialog(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 3.w),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
        child: InkWell(
          onTap: () => Navigator.pop(context),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                widget.message.fileLink.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          "https://images.pexels.com/photos/2147029/pexels-photo-2147029.jpeg?auto=compress&cs=tinysrgb&w=600",
                          height: 30.h,
                          width: 60.w,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Bubble(
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
                    top: 1.h,
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
                        function: () {
                          passMessageForReply();
                        },
                      ),
                      // Visibility(
                      //   visible: isMe,
                      //   child: BubbleActionTile(
                      //     title: "Info",
                      //     icon: Icons.info_rounded,
                      //     function: () {},
                      //   ),
                      // ),
                      BubbleActionTile(
                        title: "Copy",
                        icon: Icons.copy_rounded,
                        function: () async {
                          await copyToClipboard(widget.message.text);
                          if (mounted) {
                            Navigator.pop(context);
                          }
                        },
                      ),
                      Visibility(
                        visible: canDelete,
                        child: BubbleActionTile(
                          title: "Delete",
                          icon: Icons.delete_rounded,
                          function: deleteMessage,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getUser() async {
    var userProvider = Provider.of<UsersProvider>(context, listen: false);

    user = await userProvider.getUser(widget.message.userId);
  }

  Future<void> copyToClipboard(String textToCopy) async {
    await Clipboard.setData(ClipboardData(text: textToCopy));

    Fluttertoast.showToast(
      msg: "Copied to clipboard",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
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

    Navigator.pop(context);
  }

  void deleteMessage() {
    var lobbyProvider = Provider.of<LobbyProvider>(context, listen: false);

    lobbyProvider.deleteMessage(
      widget.lobbyId,
      widget.message.id,
    );

    Navigator.pop(context);
  }
}
