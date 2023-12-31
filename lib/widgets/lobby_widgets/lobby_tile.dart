import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/date_time_formatting.dart';
import '../../models/event.dart';
import '../../models/lobby.dart';
import '../../models/message.dart';
import '../../providers/event_provider.dart';
import '../../providers/lobby_provider.dart';
import '../../screens/lobby_screens/lobby_screen.dart';

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
  Message? message;

  @override
  Widget build(BuildContext context) {
    var eventProvider = Provider.of<EventProvider>(context, listen: false);
    var lobbyProvider = Provider.of<LobbyProvider>(context, listen: false);

    const loadingText = Text(
      "Loading...",
      style: TextStyle(
        fontStyle: FontStyle.italic,
        color: Colors.black38,
      ),
    );
    Color secondaryColor = Colors.black38;

    return FutureBuilder(
        future: eventProvider.getEvent(widget.lobby.eventId),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          const textStyle = TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.black38,
          );

          if (snapshot.hasError) {
            return const Text(
              "Something went wrong",
              style: textStyle,
            );
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Text(
              "Document does not exist",
              style: textStyle,
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text(
              "Loading lobby",
              style: textStyle,
            );
          }

          Map<String, dynamic> data =
              snapshot.data?.data() as Map<String, dynamic>;

          Event event = Event.fromJson(data);

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
            subtitle: StreamBuilder(
                stream: lobbyProvider.getLastMessage(widget.lobby.id),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return loadingText;
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return loadingText;
                  }

                  String uid =
                      lobbyProvider.authInstance.currentUser?.uid ?? "";
                  Map<String, dynamic> data =
                      snapshot.data?.docs.first.data() as Map<String, dynamic>;

                  message = Message.fromJson(data);

                  bool isSeen = message?.isSeen.contains(uid) ?? false;

                  return Row(
                    children: [
                      Icon(
                        isSeen
                            ? Icons.rocket_outlined
                            : Icons.rocket_launch_rounded,
                        color: isSeen ? secondaryColor : Colors.black,
                        size: 10.sp,
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Text(
                        isSeen ? "Opened" : "Delivered ",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 9.sp,
                          color: secondaryColor,
                        ),
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      Icon(
                        Icons.circle,
                        color: secondaryColor,
                        size: 3.sp,
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      Text(
                        DateTimeFormatting.timeAgo(
                          message?.dateTime ?? DateTime.now(),
                        ),
                        style: TextStyle(
                          color: secondaryColor,
                          fontSize: 9.sp,
                          fontFamily: "Poppins",
                        ),
                      ),
                    ],
                  );
                }),
          );
        });
  }
}
