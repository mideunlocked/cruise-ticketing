import 'package:cruise/screens/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/event.dart';
import '../../models/users.dart';
import '../../providers/event_provider.dart';
import '../../providers/users_provider.dart';
import '../../widgets/general_widgets/empty_search_widget.dart';
import '../../widgets/general_widgets/profile_image.dart';
import '../../widgets/home_screen_widgets/event_today_tile.dart';
import '../../widgets/search_widgets/search_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller = TextEditingController();

  FocusNode node = FocusNode();

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
    node.dispose();
  }

  Iterable<Event> searchEventResult = [];
  Iterable<Users> searchUserResult = [];

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var primaryColor = of.primaryColor;

    var textTheme = of.textTheme;
    var bodyMedium = textTheme.bodyMedium;

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
                : searchEventResult.isEmpty && searchUserResult.isEmpty
                    ? EmptySearchWidget(
                        searchKeyWord: controller.text.trim(),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          searchUserResult.isEmpty
                              ? const SizedBox()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SearchHeader(
                                      text: "People",
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                      width: 100.w,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: searchUserResult
                                            .map(
                                              (e) => UserTile(
                                                user: e,
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                  ],
                                ),
                          controller.text.isEmpty
                              ? const SizedBox()
                              : const SearchHeader(text: "Events"),
                          searchEventResult.isEmpty
                              ? const SizedBox()
                              : Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 4.w),
                                  child: Column(
                                    children: searchEventResult
                                        .map(
                                          (e) => EventListTile(
                                            event: e,
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                        ],
                      ),
          ],
        ),
      ),
    );
  }

  void searchKeyword() {
    final eventProvider = Provider.of<EventProvider>(context, listen: false);
    final userProvider = Provider.of<UsersProvider>(context, listen: false);

    setState(() {
      searchEventResult = eventProvider.events
          .where((e) => e.name.toLowerCase().contains(controller.text.trim()));
      searchUserResult = userProvider.users.where((e) {
        bool checkName = e.name.toLowerCase().contains(controller.text.trim());
        bool checkUsername =
            e.username.toLowerCase().contains(controller.text.trim());

        if (checkName == true || checkUsername == true) {
          return true;
        }
        return false;
      });
    });
  }
}

class SearchHeader extends StatelessWidget {
  const SearchHeader({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w),
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
        ],
      ),
    );
  }
}

class UserTile extends StatefulWidget {
  const UserTile({
    super.key,
    required this.user,
  });

  final Users user;

  @override
  State<UserTile> createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  bool isFollowing = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => UserProfileScreen(userId: widget.user.id),
          ),
        );
      },
      child: Container(
        height: 20.h,
        width: 85.w,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.only(left: 4.w, right: 1.w),
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
        child: Row(
          children: [
            ProfileImage(
              imageUrl: widget.user.imageUrl,
              radius: 50.sp,
              userId: "1",
              isAuthUser: true,
            ),
            SizedBox(
              width: 5.w,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.user.name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "@${widget.user.username}",
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 10.sp,
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        isFollowing ? Colors.grey[200] : Colors.black),
                  ),
                  onPressed: toggleFollow,
                  child: Text(
                    isFollowing ? "Following" : "Follow",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      color: isFollowing ? Colors.black : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void toggleFollow() {
    setState(() {
      isFollowing = !isFollowing;
    });
  }
}

// const ShimmerLoadingTile(),