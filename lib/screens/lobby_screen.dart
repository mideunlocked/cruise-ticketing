import 'package:cruise/widgets/lobby_widgets/bubble.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../models/event.dart';
import '../models/lobby.dart';
import '../models/message.dart';

class LobbyScreen extends StatefulWidget {
  const LobbyScreen({
    super.key,
    required this.lobby,
    required this.event,
  });

  final Lobby lobby;
  final Event? event;

  @override
  State<LobbyScreen> createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: 3.w,
                ),
                itemCount: widget.lobby.messages.length,
                itemBuilder: (ctx, index) {
                  Message message = widget.lobby.messages[index];
                  return MessageBubble(message: message);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
