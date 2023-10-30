import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'more_list_tile_asset.dart';
import 'more_list_tile_icon.dart';

class ProfileBottomSheet extends StatelessWidget {
  const ProfileBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 2.w,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 2.h,
            ),
            MoreListTileAsset(
              title: "Wallet",
              iconUrl: "wallet",
              function: () => Navigator.pushNamed(
                context,
                "/WalletScreen",
              ),
            ),
            MoreListTileAsset(
              title: "Tickets",
              iconUrl: "tickets",
              function: () => Navigator.pushNamed(
                context,
                "/TicketListScreen",
              ),
            ),
            MoreListTileIcon(
              title: "Saved",
              icon: Icons.favorite_outline_rounded,
              function: () => Navigator.pushNamed(
                context,
                "/SavedEventScreen",
              ),
            ),
            MoreListTileIcon(
              icon: Icons.info_outline_rounded,
              title: "Help center",
              function: () {},
            ),
            MoreListTileIcon(
              icon: Icons.star_outline_rounded,
              title: "Rate us",
              function: () {},
            ),
            MoreListTileAsset(
              title: "Sign out",
              iconUrl: "exit",
              function: () {
                FirebaseAuth.instance.signOut().then(
                      (value) => Navigator.pushNamedAndRemoveUntil(
                        context,
                        "/WelcomeScreen",
                        (route) => false,
                      ),
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}
