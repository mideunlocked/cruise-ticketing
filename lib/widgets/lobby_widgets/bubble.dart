import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/message.dart';
import '../../models/users.dart';
import '../../providers/users_provider.dart';
import '../../screens/user_profile_screen.dart';

class Bubble extends StatelessWidget {
  const Bubble({
    super.key,
    required this.paddingInsets,
    required this.checkIsMe,
    required this.message,
    required this.user,
  });

  final EdgeInsets paddingInsets;
  final bool checkIsMe;
  final Message message;
  final Users? user;

  @override
  Widget build(BuildContext context) {
    var marginInsets = EdgeInsets.only(
      left: checkIsMe ? 15.w : 0,
      right: checkIsMe ? 0 : 15.w,
      bottom: 2.h,
    );
    bool checkAdminDeleted = message.checkDeletedBy("0");

    var userProvider = Provider.of<UsersProvider>(context, listen: false);

    return Container(
      margin: marginInsets.copyWith(bottom: 0.5.h),
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
          message.isDeleted
              ? const SizedBox()
              : Visibility(
                  visible: message.userId != "0",
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) =>
                              UserProfileScreen(userId: user?.id ?? ""),
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
            message.isDeleted
                ? message.deletedBy == userProvider.userData.id
                    ? "You deleted this message"
                    : checkAdminDeleted
                        ? "This message was deleted by admin"
                        : "This message was deleted"
                : message.text,
            style: TextStyle(
              color: checkIsMe
                  ? message.isDeleted
                      ? Colors.white38
                      : Colors.white
                  : message.isDeleted
                      ? Colors.black26
                      : null,
              fontStyle:
                  message.isDeleted ? FontStyle.italic : FontStyle.normal,
            ),
          ),
        ],
      ),
    );
  }
}
