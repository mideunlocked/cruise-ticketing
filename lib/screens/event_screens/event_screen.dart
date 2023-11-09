import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/event.dart';
import '../../models/ticket.dart';
import '../../models/users.dart';
import '../../providers/event_provider.dart';
import '../../providers/ticket_provider.dart';
import '../../providers/users_provider.dart';
import '../../widgets/event_screen_widgets/about_widget.dart';
import '../../widgets/event_screen_widgets/buy_tickets_button.dart';
import '../../widgets/event_screen_widgets/custom_tab_bar.dart';
import '../../widgets/event_screen_widgets/details_widget.dart';
import '../../widgets/event_screen_widgets/event_image_widget.dart';
import '../../widgets/event_screen_widgets/host_event_action_button.dart';
import '../../widgets/event_screen_widgets/view_ticket.dart';

class EventScreen extends StatefulWidget {
  static const routeName = "/EventScreen";

  const EventScreen({
    super.key,
    required this.durationData,
    required this.event,
    this.isInitial = false,
    required this.host,
  });

  final Map<String, dynamic> durationData;
  final Event event;
  final Users? host;
  final bool
      isInitial; // check if event is being view by the host after creation

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  // holds about is selected
  bool isAbout = true;

  // holds detail is selected
  bool isDetails = false;

  // holds event sold out
  bool isSoldOut = false;

  // holds ticket if user has event ticket
  bool hasTicket = false;
  Ticket? ticket;

  @override
  void initState() {
    super.initState();

    isSoldOut = widget.event.analysis.checkSoldOut();
    checkIfTicket();
  }

  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(height: 3.h);

    var eventProvider = Provider.of<EventProvider>(context);
    var userProvider = Provider.of<UsersProvider>(context);
    var userData = userProvider.userData;

    return WillPopScope(
      onWillPop: () async {
        widget.isInitial
            ? Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false)
            : Navigator.pop(context);

        throw 0;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EventImageWidget(
                imageUrl: widget.event.imageUrl,
                isSaved: eventProvider.savedEvents.contains(widget.event.id),
                isInitial: widget.isInitial,
                eventId: widget.event.id,
                isSoldOut: isSoldOut,
              ),

              // this widget holds the name of the event and the custom tab bar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // event name
                    SizedBox(
                      width: 90.w,
                      child: Text(
                        widget.event.name,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2.0,
                          wordSpacing: 4.0,
                        ),
                      ),
                    ),

                    // some space
                    SizedBox(height: 1.h),

                    // custom tab bar
                    CustomTabBar(
                      toggleTab: toggleTab,
                      isAbout: isAbout,
                      isDetails: isDetails,
                    )
                  ],
                ),
              ),

              // about and details widget
              isAbout == true // checks if about tab is currently selected
                  ?
                  // then displays is

                  About(
                      sizedBox: sizedBox,
                      widget: widget,
                    )
                  :
                  // else details is selected and displays it
                  Details(
                      widget: widget,
                      sizedBox: sizedBox,
                    ),

              // some space
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),

        // buy ticket floating action button which also
        //intiates the pricing and category bottom sheet
        floatingActionButton: userData.id != widget.event.hostId
            ? hasTicket
                ? ViewTicket(
                    ticket: ticket ??
                        const Ticket(
                            price: "0",
                            status: false,
                            eventId: "",
                            category: "",
                            ticketId: ""),
                  )
                : Visibility(
                    visible: !isSoldOut,
                    child: BuyTicketButton(
                      event: widget.event,
                    ),
                  )
            : HostEventActionButton(
                event: widget.event,
              ),
      ),
    );
  }

  // function to toggle the custom tab bar
  void toggleTab() {
    setState(() {
      isAbout == true
          ? {
              isAbout = false,
              isDetails = true,
            }
          : {
              isDetails = false,
              isAbout = true,
            };
    });
  }

  void checkIfTicket() {
    var ticketProvider = Provider.of<TicketProvider>(context, listen: false);
    var ticketResult = ticketProvider.checkTicket(widget.event.id);

    if (ticketResult != false) {
      hasTicket = true;
      ticket = ticketResult;
    }
  }
}
