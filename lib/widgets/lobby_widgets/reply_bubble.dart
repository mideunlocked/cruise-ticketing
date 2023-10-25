import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/message.dart';
import '../../models/users.dart';
import '../../providers/lobby_provider.dart';
import '../../providers/users_provider.dart';

class ReplyBubble extends StatelessWidget {
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
  Widget build(BuildContext context) {
    var marginInsets = EdgeInsets.only(
      left: checkIsMe ? 25.w : 0,
      right: checkIsMe ? 0 : 25.w,
      bottom: 0.5,
    );

    return InkWell(
      onTap: () => scrollToMessage(context),
      child: message.reply!.fileLink.toString().isNotEmpty
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
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.red[200],
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
            ),
    );
  }

  Users getUser(BuildContext context) {
    var userProvider = Provider.of<UsersProvider>(context, listen: false);

    return userProvider.getUser(message.reply?.messageUserId ?? "");
  }

  void scrollToMessage(BuildContext context) {
    var lobbyProvider = Provider.of<LobbyProvider>(context, listen: false);

    // Calculate the position of the item based on its index
    double itemPosition = lobbyProvider
            .getMessages(message.reply?.lobbyId ?? "")
            .reversed
            .toList()
            .indexWhere((element) => element.id == message.reply?.messageId) *
        100.0; // Adjust the value as needed

    // Scroll to the calculated position with animation
    scrollController.animateTo(
      itemPosition,
      duration: const Duration(seconds: 1), // Adjust the duration as needed
      curve: Curves.easeInOut, // Adjust the curve as needed
    );
  }
}
