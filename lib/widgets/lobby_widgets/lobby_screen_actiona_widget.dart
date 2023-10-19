import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'lobby_icon_button.dart';
import 'lobby_text_field.dart';

class LobbySendActionsWidget extends StatelessWidget {
  const LobbySendActionsWidget({
    super.key,
    required this.sendMessage,
    required this.controllerHasInput,
    required this.controller,
  });

  final Function sendMessage;
  final bool controllerHasInput;
  final TextEditingController controller;

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
          child: Row(
            children: [
              LobbyTextField(
                controller: controller,
              ),
              controllerHasInput != true
                  ? LobbyIconButton(
                      iconUrl: "paper-clip",
                      function: () {},
                    )
                  : LobbyIconButton(
                      iconUrl: "send",
                      function: () => sendMessage(),
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
