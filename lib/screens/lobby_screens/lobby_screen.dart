import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/event.dart';
import '../../models/lobby.dart';
import '../../models/message.dart';
import '../../providers/lobby_provider.dart';
import '../../widgets/lobby_widgets/lobby_messages_seperator.dart';
import '../../widgets/lobby_widgets/lobby_screen_actions_widget.dart';
import '../../widgets/lobby_widgets/lobby_screen_app_bar.dart';
import '../../widgets/lobby_widgets/message_bubble.dart';

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

  @override
  void initState() {
    super.initState();

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
              child: Consumer<LobbyProvider>(
                builder: (context, value, child) => GroupedListView(
                  controller: _scrollController,
                  padding: EdgeInsets.symmetric(
                    horizontal: 3.w,
                  ),
                  reverse: true,
                  order: GroupedListOrder.DESC,
                  elements: value.getMessages(widget.lobby.id),
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
                      adminId: widget.event.hostId,
                      message: message,
                      scrollController: _scrollController,
                      lobbyId: widget.lobby.id,
                    );
                  },
                ),
              ),
            ),
            LobbySendActionsWidget(
              lobbyId: widget.lobby.id,
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
    var lobbyId = widget.lobby.id;

    var lobbyProvider = Provider.of<LobbyProvider>(context, listen: false);
    bool checkIf = lobbyProvider.checkIfTheresReply(lobbyId);

    if (controllerHasInput == true) {
      lobbyProvider.addMessage(
        widget.lobby.id,
        Message(
          id: "8",
          userId: "0",
          text: _controller.text.trim(),
          reply: checkIf ? lobbyProvider.getReplyData(lobbyId) : null,
          isSeen: [],
          fileLink: "",
          timestamp: DateTime.now(),
          isDeleted: false,
          deletedBy: "",
        ),
      );

      _controller.clear();
      lobbyProvider.deleteReply(lobbyId);
    }
  }
}
