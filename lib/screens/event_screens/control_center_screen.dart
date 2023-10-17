import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../../models/attendee.dart';
import '../../models/event.dart';
import '../../models/users.dart';
import '../../providers/users_provider.dart';
import '../../widgets/control_center_widget/attendee_search_widget.dart';
import '../../widgets/control_center_widget/attendee_tile.dart';
import '../../widgets/control_center_widget/control_center_filter.dart';
import '../../widgets/control_center_widget/failed_scan_dialog.dart';
import '../../widgets/control_center_widget/scanned_dialog.dart';
import '../../widgets/general_widgets/custom_app_bar.dart';
import '../../widgets/general_widgets/custom_button.dart';
import '../../widgets/general_widgets/empty_list_widget.dart';
import '../../widgets/general_widgets/empty_search_widget.dart';

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

  String searchQuery = '';

  Iterable<Attendee> searchAttendeeResult = [];

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UsersProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            AttendeeSearchWidget(
              passSearchQuery: getSearchQuery,
            ),
            ControlCenterFilter(
              filterIndex: filterIndex,
              changeFilter: changeFilter,
            ),
            Expanded(
              child: widget.event.attendees.isEmpty
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: const EmptyListWidget(
                        title: "No attendees yet",
                        subTitle:
                            "Currently, no attendees have been registered for this event. We appreciate your anticipation and look forward to welcoming participants soon.",
                      ),
                    )
                  : ListView(
                      children: searchAttendees().isEmpty
                          ? [EmptySearchWidget(searchKeyWord: searchQuery)]
                          : searchAttendees().map((e) {
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
                function: scanTicket,
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

  void getSearchQuery(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
    });
  }

  Iterable<Attendee> searchAttendees() {
    var userProvider = Provider.of<UsersProvider>(context);

    searchAttendeeResult = widget.event.attendees.where((element) {
      Users user;

      user = userProvider.getUser(element.userId);

      if (user.name.toLowerCase().contains(searchQuery) == true ||
          user.username.toLowerCase().contains(searchQuery) == true ||
          element.category.toLowerCase().contains(searchQuery) == true) {
        return true;
      }

      return false;
    }).where((element) {
      if (filterIndex == 1) {
        return element.isValidated == true;
      } else if (filterIndex == 2) {
        return element.isValidated == false;
      }
      return true;
    });

    return searchAttendeeResult;
  }

  Future<void> scanTicket() async {
    String scanResult;
    Attendee? attendee;
    Users? user;

    var userProvider = Provider.of<UsersProvider>(context, listen: false);

    try {
      scanResult = await FlutterBarcodeScanner.scanBarcode(
        "#000000",
        "Stop scan",
        false,
        ScanMode.QR,
      );

      attendee =
          widget.event.attendees.singleWhere((e) => e.ticketId == scanResult);

      user = userProvider.getUser(attendee.userId);

      debugPrint(scanResult);
    } on PlatformException {
      scanResult = "Not an attendee";
      debugPrint(scanResult);
    } catch (e) {
      scanResult = e.toString();
      debugPrint(e.toString());
    }

    if (!mounted) return;
    showDialog(
      context: context,
      builder: (ctx) => scanResult.contains("No element")
          ? const FailedScanDialog()
          : ScannedDialog(
              user: user,
              scanResult: scanResult,
              attendee: attendee,
            ),
    );
  }
}
