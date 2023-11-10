import 'package:cloud_firestore/cloud_firestore.dart';
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
  List<Message> messages = [];

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
    var lobbyProvider = Provider.of<LobbyProvider>(context);

    return Scaffold(
      appBar: LobbyScreenAppBar(widget: widget),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: lobbyProvider.getMessages(widget.lobby.id),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                messages = snapshot.data?.docs.map((e) {
                      Map<String, dynamic> data =
                          e.data() as Map<String, dynamic>;
                      return Message.fromJson(data);
                    }).toList() ??
                    [];

                return GroupedListView(
                  controller: _scrollController,
                  padding: EdgeInsets.symmetric(
                    horizontal: 3.w,
                  ),
                  reverse: true,
                  order: GroupedListOrder.DESC,
                  elements: messages,
                  groupBy: (element) => DateTime(
                    element.dateTime.year,
                    element.dateTime.month,
                    element.dateTime.day,
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
                );
              },
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
    );
  }

  void sendMessage() {
    var lobbyId = widget.lobby.id;

    var lobbyProvider = Provider.of<LobbyProvider>(context, listen: false);
    bool checkIf = lobbyProvider.checkIfTheresReply(lobbyId);

    String? uid = lobbyProvider.authInstance.currentUser?.uid ?? "";

    if (controllerHasInput == true) {
      lobbyProvider.addMessage(
        widget.lobby.id,
        Message(
          id: "",
          userId: uid,
          text: _controller.text.trim(),
          reply: checkIf ? lobbyProvider.getReplyData(lobbyId) : null,
          isSeen: [uid],
          fileLink: "",
          dateTime: DateTime.now(),
          isDeleted: false,
          deletedBy: "",
        ),
      );

      _controller.clear();
      lobbyProvider.deleteReply(lobbyId);
    }
  }
}
