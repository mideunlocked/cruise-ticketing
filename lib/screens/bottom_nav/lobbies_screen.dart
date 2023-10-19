import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/event.dart';
import '../../models/lobby.dart';
import '../../providers/event_provider.dart';
import '../../providers/lobby_provider.dart';
import '../lobby_screen.dart';

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

class LobbyTile extends StatefulWidget {
  const LobbyTile({
    super.key,
    required this.lobby,
  });

  final Lobby lobby;

  @override
  State<LobbyTile> createState() => _LobbyTileState();
}

class _LobbyTileState extends State<LobbyTile> {
  Event? event;

  @override
  void initState() {
    super.initState();

    getLobbyEvent();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => LobbyScreen(
              lobby: widget.lobby,
              event: event,
            ),
          ),
        );
      },
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          event?.imageUrl ?? "",
          height: 8.h,
          width: 20.w,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        "${event?.name}",
        maxLines: 1,
        softWrap: true,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Row(
        children: [
          const Text(
            "New message",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 3.w,
          ),
          Icon(
            Icons.circle_rounded,
            color: Colors.black,
            size: 5.sp,
          ),
        ],
      ),
      trailing: Text(
        "1hr",
        style: TextStyle(
          color: Colors.black45,
          fontSize: 10.sp,
        ),
      ),
    );
  }

  void getLobbyEvent() {
    var eventProvider = Provider.of<EventProvider>(context, listen: false);

    event = eventProvider.getEvent(widget.lobby.eventId);
  }
}

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
