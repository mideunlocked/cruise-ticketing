import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/attendee.dart';
import '../../models/event.dart';
import '../../models/users.dart';
import '../../providers/users_provider.dart';
import '../../widgets/general_widgets/custom_app_bar.dart';
import '../../widgets/general_widgets/custom_button.dart';
import '../../widgets/general_widgets/profile_image.dart';

class ControlCenterScreen extends StatefulWidget {
  const ControlCenterScreen({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  State<ControlCenterScreen> createState() => _ScanEventScreenState();
}

class _ScanEventScreenState extends State<ControlCenterScreen> {
  int filterIndex = 0;

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UsersProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: CustomAppBar(
                title: "Control center",
                bottomPadding: 1.h,
              ),
            ),
            ControlCenterFilter(
              filterIndex: filterIndex,
              changeFilter: changeFilter,
            ),
            Expanded(
              child: ListView(
                children: widget.event.attendees.where((element) {
                  if (filterIndex == 1) {
                    return element.isValidated == true;
                  } else if (filterIndex == 2) {
                    return element.isValidated == false;
                  }
                  return true;
                }).map((e) {
                  Users user;

                  user = userProvider.getUser(e.userId);

                  return AttendeeTile(
                    attendee: e,
                    user: user,
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: CustomButton(
                title: "Scan ticket",
                function: () {},
              ),
            )
          ],
        ),
      ),
    );
  }

  void changeFilter(int newIndex) {
    setState(() {
      filterIndex = newIndex;
    });
  }
}

class ControlCenterFilter extends StatelessWidget {
  const ControlCenterFilter({
    super.key,
    required this.filterIndex,
    required this.changeFilter,
  });

  final Function(int) changeFilter;
  final int filterIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 4.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ControlCenterFilterContainer(
            currentIndex: filterIndex,
            index: 0,
            text: "Attendees",
            changeFilter: changeFilter,
          ),
          ControlCenterFilterContainer(
            currentIndex: filterIndex,
            index: 1,
            text: "Verified",
            changeFilter: changeFilter,
          ),
          ControlCenterFilterContainer(
            currentIndex: filterIndex,
            index: 2,
            text: "Unverified",
            changeFilter: changeFilter,
          ),
        ],
      ),
    );
  }
}

class AttendeeTile extends StatelessWidget {
  const AttendeeTile({
    super.key,
    required this.attendee,
    required this.user,
  });

  final Attendee attendee;
  final Users user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 1.h,
        horizontal: 3.w,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileImage(
                imageUrl: user.imageUrl,
                radius: 40.sp,
                userId: attendee.userId,
              ),
              SizedBox(width: 2.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textBox(
                    user.name,
                    fontWeight: FontWeight.bold,
                  ),
                  textBox("@${user.username}"),
                  textBox(user.number),
                  textBox(user.email),
                  textBox(
                    attendee.category,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              const Spacer(),
              Icon(
                attendee.isValidated
                    ? Icons.check_circle_outline_rounded
                    : Icons.circle_outlined,
                color: attendee.isValidated ? Colors.green : Colors.grey,
              ),
            ],
          ),
          const Divider(
            color: Colors.black12,
          ),
        ],
      ),
    );
  }

  SizedBox textBox(
    String text, {
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return SizedBox(
      width: 50.w,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}

class ControlCenterFilterContainer extends StatelessWidget {
  const ControlCenterFilterContainer({
    super.key,
    required this.currentIndex,
    required this.text,
    required this.index,
    required this.changeFilter,
  });

  final Function(int) changeFilter;
  final int currentIndex;
  final String text;
  final int index;

  @override
  Widget build(BuildContext context) {
    bool isCurrent = currentIndex == index;

    return InkWell(
      onTap: () {
        changeFilter(index);
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        margin: EdgeInsets.only(
            left: index == 0 ? 3.w : 0, right: 2.w, bottom: 1.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isCurrent ? Colors.black : Colors.grey[200],
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: isCurrent ? Colors.white : null,
          ),
        ),
      ),
    );
  }
}

class QRScannerHint extends StatefulWidget {
  const QRScannerHint({super.key});

  @override
  State<QRScannerHint> createState() => _QRScannerHintState();
}

class _QRScannerHintState extends State<QRScannerHint> {
  bool showHint = true;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var primaryColor = of.primaryColor;

    return Visibility(
      visible: showHint,
      child: Container(
        height: 30.h,
        width: 100.w,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(50),
          ),
          color: primaryColor,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 5.w,
          vertical: 5.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  showHint = false;
                });
              },
              icon: Image.asset(
                "assets/icons/close.png",
                color: Colors.white,
                height: 4.h,
                width: 4.w,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              "Align QR Code Within Frame To Scan",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
