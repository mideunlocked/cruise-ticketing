import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cruise/widgets/general_widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../models/event.dart';
import '../../models/users.dart';
import '../../widgets/home_screen_widgets/event_today_tile.dart';
import '../../widgets/search_widgets/search_header.dart';
import '../../widgets/search_widgets/search_widget.dart';
import '../../widgets/search_widgets/user_tile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller = TextEditingController();

  FocusNode node = FocusNode();

  bool searchEmpty = true;

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
    node.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var primaryColor = of.primaryColor;

    var textTheme = of.textTheme;
    var bodyMedium = textTheme.bodyMedium;

    final Stream<QuerySnapshot> eventsStream =
        FirebaseFirestore.instance.collection('events').snapshots();
    final Stream<QuerySnapshot> usersStream =
        FirebaseFirestore.instance.collection('users').snapshots();

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, "/");
        throw 1;
      },
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 2.h,
            ),
            SearchWidget(
              primaryColor: primaryColor,
              controller: controller,
              node: node,
              bodyMedium: bodyMedium,
              search: () => searchKeyword(),
            ),
            const Divider(
              color: Colors.white24,
            ),
            controller.text.isEmpty
                ? Text(
                    "Try searching for events, people or keywords",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w500,
                      fontSize: 10.sp,
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SearchHeader(
                            text: "People",
                          ),
                          SizedBox(
                            height: 20.h,
                            width: 100.w,
                            child: StreamBuilder<QuerySnapshot>(
                                stream: usersStream,
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    return const SizedBox();
                                  }

                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CustomLoadingIndicator(
                                        height: 50.h, width: 50.w);
                                  }

                                  return ListView(
                                    scrollDirection: Axis.horizontal,
                                    children:
                                        snapshot.data!.docs.where((element) {
                                      if (element["fullName"]
                                          .toString()
                                          .toLowerCase()
                                          .contains(
                                            controller.text
                                                .trim()
                                                .toLowerCase(),
                                          )) {
                                        return true;
                                      }

                                      if (element["username"]
                                          .toString()
                                          .contains(
                                            controller.text.trim(),
                                          )) {
                                        return true;
                                      }
                                      return false;
                                    }).map((DocumentSnapshot docSnap) {
                                      Map<String, dynamic> data = docSnap
                                          .data()! as Map<String, dynamic>;
                                      Users user = Users.fromJson(data);

                                      return UserTile(
                                        user: user,
                                      );
                                    }).toList(),
                                  );
                                }),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                        ],
                      ),
                      controller.text.isEmpty
                          ? const SizedBox()
                          : const SearchHeader(text: "Events"),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: StreamBuilder<QuerySnapshot>(
                            stream: eventsStream,
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return const SizedBox();
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CustomLoadingIndicator(
                                    height: 50.h, width: 50.w);
                              }

                              return Column(
                                children: snapshot.data!.docs
                                    .where(
                                  (element) => element["name"]
                                      .toString()
                                      .toLowerCase()
                                      .contains(
                                          controller.text.trim().toLowerCase()),
                                )
                                    .map(
                                  (DocumentSnapshot docSnap) {
                                    Map<String, dynamic> data =
                                        docSnap.data()! as Map<String, dynamic>;
                                    Event event = Event.fromJson(data);

                                    return EventListTile(
                                      event: event,
                                    );
                                  },
                                ).toList(),
                              );
                            }),
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }

  void searchKeyword() {
    setState(() {
      controller.text.trim();
    });
  }
}
