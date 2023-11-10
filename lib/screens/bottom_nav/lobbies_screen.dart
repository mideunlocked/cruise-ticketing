import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cruise/widgets/general_widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/lobby.dart';
import '../../providers/lobby_provider.dart';
import '../../widgets/lobby_widgets/lobby_app_bar.dart';
import '../../widgets/lobby_widgets/lobby_tile.dart';

class LobbiesScreen extends StatelessWidget {
  const LobbiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var lobbyProvider = Provider.of<LobbyProvider>(context);

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(
          context,
          "/",
          (route) => false,
        );

        throw 0;
      },
      child: SafeArea(
        child: Column(
          children: [
            const LobbyAppBar(),
            Expanded(
              child: StreamBuilder(
                  stream: lobbyProvider.getLobbies(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text(
                        'Something went wrong, check internet connection and try again',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 10.sp,
                          fontStyle: FontStyle.italic,
                        ),
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CustomLoadingIndicator(
                        height: 50.h,
                        width: 50.w,
                      );
                    }

                    return ListView(
                      children: snapshot.data?.docs
                              .map((QueryDocumentSnapshot docSnap) {
                            Map<String, dynamic> data =
                                docSnap.data()! as Map<String, dynamic>;

                            Lobby lobby = Lobby.fromJson(data);

                            return LobbyTile(lobby: lobby);
                          }).toList() ??
                          [],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
