import 'dart:io';

import 'package:cruise/screens/lobby_screens/lobby_view_send_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../providers/lobby_provider.dart';
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

class FilePickerWidget extends StatelessWidget {
  const FilePickerWidget({
    super.key,
    required this.lobbyId,
  });

  final String lobbyId;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.h,
      width: 100.w,
      margin: EdgeInsets.symmetric(
        horizontal: 2.w,
        vertical: 1.h,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FilePickerType(
            title: "Camera",
            iconUrl: "camera",
            lobbyId: lobbyId,
          ),
          FilePickerType(
            title: "Gallery",
            iconUrl: "image",
            lobbyId: lobbyId,
          ),
        ],
      ),
    );
  }
}

class FilePickerType extends StatefulWidget {
  const FilePickerType({
    super.key,
    required this.iconUrl,
    required this.title,
    required this.lobbyId,
  });

  final String lobbyId;
  final String iconUrl;
  final String title;

  @override
  State<FilePickerType> createState() => _FilePickerTypeState();
}

class _FilePickerTypeState extends State<FilePickerType> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => pickFile(),
      child: Container(
        width: 40.w,
        height: 15.h,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black26),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/icons/${widget.iconUrl}.png",
              height: 10.h,
              width: 15.w,
              color: Colors.black45,
            ),
            Text(
              widget.title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black45,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void pickFile() async {
    XFile? pickedImage;

    if (widget.title == "Camera") {
      pickedImage = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
      );
    } else {
      pickedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 75,
      );
    }

    if (pickedImage == null) {
      return;
    }

    if (mounted) {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => LobbyViewSendImageScreen(
            image: File(pickedImage!.path),
            lobbyId: widget.lobbyId,
          ),
        ),
      );
    }
  }
}
