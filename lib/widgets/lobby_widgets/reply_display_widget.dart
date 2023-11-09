import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/reply.dart';
import '../../models/users.dart';
import '../../providers/lobby_provider.dart';
import '../../providers/users_provider.dart';

class ReplyDisplayWidget extends StatefulWidget {
  const ReplyDisplayWidget({
    super.key,
    required this.lobbyId,
  });

  final String lobbyId;

  @override
  State<ReplyDisplayWidget> createState() => _ReplyDisplayWidgetState();
}

class _ReplyDisplayWidgetState extends State<ReplyDisplayWidget> {
  Users? user;

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UsersProvider>(context, listen: false);

    return Consumer<LobbyProvider>(
      builder: (context, value, child) {
        Reply reply = value.getReplyData(widget.lobbyId);
        getUser(context, reply.messageUserId, userProvider);
        String displayName = user?.id == userProvider.userData.id
            ? "yourself"
            : user?.username ?? "";

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Replying to $displayName",
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 8.sp,
                  ),
                ),
                SizedBox(
                  height: 0.2.h,
                ),
                reply.fileLink.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          "https://images.pexels.com/photos/2147029/pexels-photo-2147029.jpeg?auto=compress&cs=tinysrgb&w=600",
                          height: 10.h,
                          width: 20.w,
                          fit: BoxFit.cover,
                        ),
                      )
                    : SizedBox(
                        width: 80.w,
                        child: Text(
                          reply.text,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                      ),
                SizedBox(
                  height: 1.h,
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                value.deleteReply(widget.lobbyId);
              },
              icon: Image.asset(
                "assets/icons/close.png",
                height: 3.h,
                width: 3.w,
              ),
            ),
          ],
        );
      },
    );
  }

  void getUser(
      BuildContext context, String userId, UsersProvider userProvider) async {
    user = await userProvider.getUser(userId);
  }
}
