import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/users.dart';
import '../../providers/users_provider.dart';
import '../../screens/user_profile_screen.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({
    super.key,
    required this.imageUrl,
    required this.radius,
    this.isAuthUser = false,
    required this.userId,
  });

  final String imageUrl;
  final double radius;
  final bool isAuthUser;
  final String userId;

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  Users? user;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: () => widget.isAuthUser
          ? null
          : Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => UserProfileScreen(
                  userId: widget.userId,
                ),
              ),
            ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).scaffoldBackgroundColor,
            width: 3,
          ),
          shape: BoxShape.circle,
        ),
        child: CircleAvatar(
          radius: widget.radius,
          foregroundImage: NetworkImage(
            widget.imageUrl,
          ),
        ),
      ),
    );
  }

  void getHost(BuildContext context) async {
    var userProvider = Provider.of<UsersProvider>(context, listen: false);

    user = await userProvider.getUser(widget.userId);
  }
}
