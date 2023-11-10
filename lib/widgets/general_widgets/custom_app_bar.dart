import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  const CustomAppBar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: IconButton(
        onPressed: () => Navigator.of(context),
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
        ),
      ),
      title: Text(title),
    );
  }
}
