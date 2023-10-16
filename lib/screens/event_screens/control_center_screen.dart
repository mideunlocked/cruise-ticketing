import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/event.dart';
import '../../models/users.dart';
import '../../providers/users_provider.dart';
import '../../widgets/control_center_widget/attendee_tile.dart';
import '../../widgets/control_center_widget/control_center_filter.dart';
import '../../widgets/general_widgets/custom_app_bar.dart';
import '../../widgets/general_widgets/custom_button.dart';

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
