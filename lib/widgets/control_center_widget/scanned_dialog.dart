import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../models/attendee.dart';
import '../../models/users.dart';
import '../general_widgets/profile_image.dart';

class ScannedDialog extends StatefulWidget {
  const ScannedDialog({
    super.key,
    required this.user,
    required this.scanResult,
    required this.attendee,
  });

  final Users? user;
  final Attendee? attendee;
  final String scanResult;

  @override
  State<ScannedDialog> createState() => _ScannedDialogState();
}

class _ScannedDialogState extends State<ScannedDialog> {
  @override
  Widget build(BuildContext context) {
    String? timeago = widget.attendee?.getTimeAgo();
    bool isValidated = widget.attendee!.isValidated;

    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 20.h,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.h),
        child: Column(
          children: [
            ProfileImage(
              imageUrl: widget.user?.imageUrl ?? "",
              radius: 20.w,
              userId: widget.user?.id ?? "",
              isAuthUser: false,
            ),
            Text(
              widget.user?.name ?? "",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text("@${widget.user?.username}"),
            LottieBuilder.asset(
              "assets/lottie/checked_in.json",
            ),
            Text(
              isValidated ? "Already scanned: $timeago" : "Validated",
              style: TextStyle(
                color: isValidated ? Colors.red[900] : Colors.green[900],
                fontWeight: FontWeight.w900,
                fontSize: 14.sp,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
