import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
              child: ListView(
                  children: lobbyProvider.lobbies
                      .map(
                        (lobby) => LobbyTile(lobby: lobby),
                      )
                      .toList()),
            ),
          ],
        ),
      ),
    );
  }
}
