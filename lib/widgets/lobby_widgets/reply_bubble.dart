import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/message.dart';
import '../../models/users.dart';
import '../../providers/lobby_provider.dart';
import '../../providers/users_provider.dart';

class ReplyBubble extends StatefulWidget {
  const ReplyBubble({
    super.key,
    required this.paddingInsets,
    required this.message,
    required this.checkIsMe,
    required this.scrollController,
  });

  final ScrollController scrollController;
  final EdgeInsets paddingInsets;
  final Message message;
  final bool checkIsMe;

  @override
  State<ReplyBubble> createState() => _ReplyBubbleState();
}

class _ReplyBubbleState extends State<ReplyBubble> {
  Users? user;

  @override
  void initState() {
    super.initState();

    getUser();
  }

  @override
  Widget build(BuildContext context) {
    var marginInsets = EdgeInsets.only(
      left: widget.checkIsMe ? 25.w : 0,
      right: widget.checkIsMe ? 0 : 25.w,
      bottom: 0.5,
    );

    return InkWell(
      onTap: () => scrollToMessage(context),
      child: widget.message.reply!.fileLink.toString().isNotEmpty
          ? ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.grey[200]!, // The color you want to use for the filter
                  BlendMode.overlay,
                ),
                child: Image.network(
                  "https://images.pexels.com/photos/2147029/pexels-photo-2147029.jpeg?auto=compress&cs=tinysrgb&w=600",
                  width: 25.w,
                  height: 13.h,
                  fit: BoxFit.cover,
                ),
              ),
            )
          : Container(
              margin: marginInsets,
              padding: widget.paddingInsets,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.message.reply!.messageUserId == "0"
                        ? "You"
                        : user?.username ?? "",
                    style: TextStyle(
                      fontSize: 8.sp,
                      color: Colors.red[200],
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.red[200],
                    ),
                  ),
                  Text(
                    widget.message.reply?.text ?? "",
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black54, fontSize: 8.sp),
                  ),
                ],
              ),
            ),
    );
  }

  void getUser() async {
    var userProvider = Provider.of<UsersProvider>(context, listen: false);

    user = await userProvider.getUser(widget.message.userId);
  }

  void scrollToMessage(BuildContext context) {
    var lobbyProvider = Provider.of<LobbyProvider>(context, listen: false);

    // Calculate the position of the item based on its index
    double itemPosition = lobbyProvider
            .getMessages(widget.message.reply?.lobbyId ?? "")
            .reversed
            .toList()
            .indexWhere(
                (element) => element.id == widget.message.reply?.messageId) *
        100.0; // Adjust the value as needed

    // Scroll to the calculated position with animation
    widget.scrollController.animateTo(
      itemPosition,
      duration: const Duration(seconds: 1), // Adjust the duration as needed
      curve: Curves.easeInOut, // Adjust the curve as needed
    );
  }
}
