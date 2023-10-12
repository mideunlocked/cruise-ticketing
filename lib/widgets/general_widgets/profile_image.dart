import 'package:cruise/screens/user_profile_screen.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
    required this.imageUrl,
    required this.radius,
    this.isAuthUser = false,
  });

  final String imageUrl;
  final double radius;
  final bool isAuthUser;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: () => isAuthUser
          ? null
          : Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => const UserProfileScreen(),
              ),
            ),
      child: CircleAvatar(
        radius: radius,
        foregroundImage: NetworkImage(
          imageUrl,
        ),
      ),
    );
  }
}
