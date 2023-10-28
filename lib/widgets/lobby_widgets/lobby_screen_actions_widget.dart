import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../providers/lobby_provider.dart';
import 'file_picker_widget.dart';
import 'lobby_icon_button.dart';
import 'lobby_text_field.dart';
import 'reply_display_widget.dart';

class LobbySendActionsWidget extends StatefulWidget {
  const LobbySendActionsWidget({
    super.key,
    required this.sendMessage,
    required this.controllerHasInput,
    required this.controller,
    required this.lobbyId,
  });

  final String lobbyId;
  final Function sendMessage;
  final bool controllerHasInput;
  final TextEditingController controller;

  @override
  State<LobbySendActionsWidget> createState() => _LobbySendActionsWidgetState();
}

class _LobbySendActionsWidgetState extends State<LobbySendActionsWidget> {
  File? file;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          height: 0.5,
          thickness: 0.5,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 2.w,
            vertical: 1.h,
          ),
          child: Column(
            children: [
              Consumer<LobbyProvider>(
                builder: (context, value, child) => Visibility(
                  visible: value.checkIfTheresReply(widget.lobbyId),
                  child: ReplyDisplayWidget(
                    lobbyId: widget.lobbyId,
                  ),
                ),
              ),
              Row(
                children: [
                  file?.existsSync() ?? false
                      ? Image.file(file ?? File(""))
                      : LobbyTextField(
                          controller: widget.controller,
                        ),
                  widget.controllerHasInput != true
                      ? LobbyIconButton(
                          iconUrl: "paper-clip",
                          function: () => showFilePicker(context),
                        )
                      : LobbyIconButton(
                          iconUrl: "send",
                          function: () => widget.sendMessage(),
                        ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  void showFilePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => FilePickerWidget(
        lobbyId: widget.lobbyId,
      ),
    );
  }
}
