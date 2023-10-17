import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/users.dart';
import '../../providers/users_provider.dart';
import '../../widgets/followers_following_widgets/followers_following_tile.dart';
import '../../widgets/general_widgets/secondary_search_widget.dart';

class FollowersPage extends StatefulWidget {
  const FollowersPage({
    super.key,
    required this.data,
  });

  final List<dynamic> data;

  @override
  State<FollowersPage> createState() => _FollowersPageState();
}

class _FollowersPageState extends State<FollowersPage> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UsersProvider>(context, listen: false);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1.h),
            child: SecondarySearchWidget(passSearchQuery: getSearchQuery),
          ),
          searchQuery.isNotEmpty
              ? const SizedBox()
              : Padding(
                  padding: EdgeInsets.only(left: 3.w, bottom: 1.h),
                  child: const Text(
                    "All followers",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: widget.data.where((element) {
              Users user;

              user = userProvider.getUser(element);

              if (user.name.toLowerCase().contains(searchQuery)) {
                return true;
              }
              if (user.username.toLowerCase().contains(searchQuery)) {
                return true;
              }
              return false;
            }).map((e) {
              Users user;

              user = userProvider.getUser(e);

              return FollowersFollowingTile(user: user);
            }).toList(),
          ),
        ],
      ),
    );
  }

  void getSearchQuery(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
    });
  }
}
