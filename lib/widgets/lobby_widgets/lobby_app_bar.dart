import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LobbyAppBar extends StatelessWidget {
  const LobbyAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var titleLarge = textTheme.titleMedium;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 3.w,
      ),
      child: Row(
        children: [
          // Screen name Lobbies
          Text(
            "Lobbies",
            style: titleLarge,
          ),

          // some space
          const Spacer(),

          // Search lobbies icon
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(50),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(10.sp),
              child: Image.asset(
                "assets/icons/search.png",
                height: 5.h,
                width: 5.w,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
