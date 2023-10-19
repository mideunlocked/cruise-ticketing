import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../screens/lobby_screen.dart';

class LobbyScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LobbyScreenAppBar({
    super.key,
    required this.widget,
  });

  final LobbyScreen widget;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      leading: IconButton(
        onPressed: () => Navigator.of(context),
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
        ),
      ),
      title: Text(widget.event?.name ?? ""),
      actions: [
        CircleAvatar(
          radius: 13.sp,
          foregroundImage: NetworkImage(
            widget.event?.imageUrl ?? "",
          ),
        ),
        SizedBox(
          width: 1.w,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
