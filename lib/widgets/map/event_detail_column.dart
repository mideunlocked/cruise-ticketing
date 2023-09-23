import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../general_widgets/profile_image.dart';
import 'locator_event_detail.dart';

class EventDetailColumn extends StatelessWidget {
  const EventDetailColumn({
    super.key,
    required this.widget,
  });

  final LocatorEventDetail widget;

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
            widget.data["name"] ?? "",
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
            widget.data["venue"] ?? "",
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
                imageUrl:
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTApbxj4499GJJWMYvKUVnzMUBJBt1b_Aob0A&usqp=CAU",
                radius: 10.sp,
              ),

              // some spacing
              SizedBox(
                width: 2.w,
              ),

              // host name
              const Text("John Doe"),

              // some spacing
              const Spacer(),

              // event date
              Text(
                widget.data["date"] ?? "",
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
}
