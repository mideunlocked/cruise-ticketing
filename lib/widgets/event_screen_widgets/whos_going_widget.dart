import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../general_widgets/profile_image.dart';
import 'padded_widget_event_screen.dart';

class WhosGoing extends StatelessWidget {
  const WhosGoing({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PaddedWidgetEventScreen(
      child: Stack(
        children: [
          // profile image list of some people attending the event

          const SizedBox(
            width: 100,
          ),
          ProfileImage(
            imageUrl:
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQm3RFDZM21teuCMFYx_AROjt-AzUwDBROFww&usqp=CAU",
            radius: 20.sp,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: ProfileImage(
              imageUrl:
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRB-r-33_9ZqU1sAITY2wlJNXYt-qkzsLszA&usqp=CAU",
              radius: 20.sp,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: ProfileImage(
              imageUrl:
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPCjXb5kLk4GFjjgcpHIJfruGGZXUctuhtBw&usqp=CAU",
              radius: 20.sp,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 24.w),
            child: ProfileImage(
              imageUrl:
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5THWiBbv_RWTA-v_XImaLNEJj-IMaKUlpVg&usqp=CAU",
              radius: 20.sp,
            ),
          ),
        ],
      ),
    );
  }
}
