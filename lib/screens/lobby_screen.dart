import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../models/event.dart';
import '../models/lobby.dart';
import '../models/message.dart';
import '../providers/lobby_provider.dart';
import '../widgets/lobby_widgets/lobby_messages_seperator.dart';
import '../widgets/lobby_widgets/lobby_screen_actiona_widget.dart';
import '../widgets/lobby_widgets/lobby_screen_app_bar.dart';
import '../widgets/lobby_widgets/message_bubble.dart';

class LobbyScreen extends StatefulWidget {
  const LobbyScreen({
    super.key,
    required this.lobby,
    required this.event,
  });

  final Lobby lobby;
  final Event event;

  @override
  State<LobbyScreen> createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();

  bool controllerHasInput = false;

  List<Message> messages = [];

  @override
  void initState() {
    super.initState();

    var lobbyProvider = Provider.of<LobbyProvider>(context, listen: false);
    messages = lobbyProvider.getMessages(widget.lobby.id);

    // Add a listener to the TextEditingController
    _controller.addListener(controllerInputed);
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();

    super.dispose();
  }

  void controllerInputed() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        controllerHasInput = true;
      });
    } else {
      setState(() {
        controllerHasInput = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LobbyScreenAppBar(widget: widget),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GroupedListView(
                controller: _scrollController,
                padding: EdgeInsets.symmetric(
                  horizontal: 3.w,
                ),
                reverse: true,
                order: GroupedListOrder.DESC,
                elements: messages,
                groupBy: (element) => DateTime(
                  element.timestamp.year,
                  element.timestamp.month,
                  element.timestamp.day,
                ),
                groupSeparatorBuilder: (value) => LobbyMessagesSeparator(
                  value: value,
                ),
                itemBuilder: (ctx, message) {
                  return MessageBubble(
                    message: message,
                    scrollController: _scrollController,
                  );
                },
              ),
            ),
            LobbySendActionsWidget(
              controller: _controller,
              sendMessage: () => sendMessage(),
              controllerHasInput: controllerHasInput,
            ),
          ],
        ),
      ),
    );
  }

  void sendMessage() {
    var lobbyProvider = Provider.of<LobbyProvider>(context, listen: false);

    if (controllerHasInput == true) {
      lobbyProvider.addMessage(
        widget.lobby.id,
        Message(
          id: "8",
          userId: "0",
          text: _controller.text.trim(),
          reply: const Reply(
            messageId: "4",
            messageUserId: "4",
            lobbyId: "0",
            fileLink: "sj",
            text: "",
          ),
          isSeen: [],
          fileLink: "",
          timestamp: DateTime.now(),
        ),
      );

      _controller.clear();

      setState(() {
        messages = lobbyProvider.getMessages(widget.lobby.id);
      });
    }
  }
}
