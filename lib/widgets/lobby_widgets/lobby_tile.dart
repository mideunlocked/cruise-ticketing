import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/event.dart';
import '../../models/lobby.dart';
import '../../providers/event_provider.dart';
import '../../screens/lobby_screen.dart';

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
  @override
  Widget build(BuildContext context) {
    Event event = getLobbyEvent();

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
          event.imageUrl,
          height: 8.h,
          width: 20.w,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        event.name,
        maxLines: 1,
        softWrap: true,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontFamily: "Poppins",
        ),
      ),
      subtitle: Row(
        children: [
          const Text(
            "New message",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: "Poppins",
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
          fontFamily: "Poppins",
        ),
      ),
    );
  }

  Event getLobbyEvent() {
    var eventProvider = Provider.of<EventProvider>(context, listen: false);

    return eventProvider.getEvent(widget.lobby.eventId);
  }
}
