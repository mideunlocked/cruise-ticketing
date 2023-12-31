import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/attendee.dart';
import '../../models/users.dart';
import '../../providers/users_provider.dart';
import '../general_widgets/profile_image.dart';
import 'padded_widget_event_screen.dart';

class WhosGoing extends StatefulWidget {
  const WhosGoing({
    super.key,
    required this.attendees,
  });

  final List<Attendee> attendees;

  @override
  State<WhosGoing> createState() => _WhosGoingState();
}

class _WhosGoingState extends State<WhosGoing> {
  List<Users> attendees = [];

  @override
  void initState() {
    super.initState();

    getAttendees();
  }

  @override
  Widget build(BuildContext context) {
    return PaddedWidgetEventScreen(
      child: Visibility(
        visible: widget.attendees.isNotEmpty,
        child: Stack(
          children: [
            // profile image list of some people attending the event

            const SizedBox(
              width: 100,
            ),
            ProfileImage(
              imageUrl: attendees.first.imageUrl,
              radius: 20.sp,
              userId: attendees.first.id,
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: ProfileImage(
                imageUrl: attendees[1].imageUrl,
                radius: 20.sp,
                userId: attendees[1].id,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: ProfileImage(
                imageUrl: attendees[2].imageUrl,
                radius: 20.sp,
                userId: attendees[2].id,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 24.w),
              child: ProfileImage(
                imageUrl: attendees[3].imageUrl,
                radius: 20.sp,
                userId: attendees[3].id,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getAttendees() async {
    if (widget.attendees.isNotEmpty) {
      Attendee attendee;

      for (attendee in widget.attendees) {
        Users user;

        user = await getUser(attendee.userId);

        attendees.add(user);
      }
    }
  }

  Future<Users> getUser(String userId) async {
    if (userId.isNotEmpty) {
      var userProvider = Provider.of<UsersProvider>(context, listen: false);

      return await userProvider.getUser(userId);
    }
    return Future.error("error");
  }
}
