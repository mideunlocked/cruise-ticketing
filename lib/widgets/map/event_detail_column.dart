import 'package:cruise/helpers/date_time_formatting.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/users.dart';
import '../../providers/users_provider.dart';
import '../general_widgets/profile_image.dart';
import 'locator_event_detail.dart';

class EventDetailColumn extends StatefulWidget {
  const EventDetailColumn({
    super.key,
    required this.widget,
  });

  final LocatorEventDetail widget;

  @override
  State<EventDetailColumn> createState() => _EventDetailColumnState();
}

class _EventDetailColumnState extends State<EventDetailColumn> {
  Users? user;

  @override
  void initState() {
    super.initState();

    getUser();
  }

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var primaryColor = of.primaryColor;
    var hSizedBox1 = SizedBox(
      height: 0.5.h,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // event name text
        SizedBox(
          width: 55.w,
          child: Text(
            widget.widget.event.name,
            softWrap: true,
            overflow: TextOverflow.clip,
            style: TextStyle(
              color: primaryColor,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        // some spacing
        hSizedBox1,

        // event venue text
        SizedBox(
          width: 55.w,
          child: Text(
            widget.widget.event.venue,
            maxLines: 2,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        ),

        // some spacing
        hSizedBox1,

        //event host details and date
        SizedBox(
          width: 55.w,
          child: Row(
            children: [
              // host image
              ProfileImage(
                imageUrl: user?.imageUrl ?? "",
                radius: 10.sp,
                userId: widget.widget.event.hostId,
              ),

              // some spacing
              SizedBox(
                width: 2.w,
              ),

              // host name
              SizedBox(
                  width: 25.w,
                  child: Text(
                    "${user?.name}",
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  )),

              // some spacing
              const Spacer(),

              // event date
              Text(
                DateTimeFormatting.formatDateTime(widget.widget.event.date),
                style: TextStyle(
                  fontSize: 6.sp,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void getUser() async {
    var userProvider = Provider.of<UsersProvider>(context, listen: false);

    user = await userProvider.getUser(widget.widget.event.hostId);
  }
}
