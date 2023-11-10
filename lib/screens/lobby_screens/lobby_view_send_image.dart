import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/message.dart';
import '../../providers/lobby_provider.dart';

class LobbyViewSendImageScreen extends StatelessWidget {
  const LobbyViewSendImageScreen({
    super.key,
    required this.image,
    required this.lobbyId,
  });

  final File image;
  final String lobbyId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Image.asset(
            "assets/icons/close.png",
            color: Colors.white,
            height: 5.h,
            width: 5.w,
          ),
        ),
      ),
      body: Stack(
        children: [
          Image.file(
            image,
            height: 100.h,
            width: 100.w,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.white,
        onPressed: () => sendMessage(context),
        label: Row(
          children: [
            const Text(
              "Send",
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(width: 3.w),
            const Icon(
              Icons.send_rounded,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  void sendMessage(BuildContext context) {
    var lobbyProvider = Provider.of<LobbyProvider>(context, listen: false);

    String? uid = lobbyProvider.authInstance.currentUser?.uid ?? "";

    lobbyProvider.addMessage(
      lobbyId,
      Message(
        id: "",
        text: "",
        reply: null,
        isSeen: [uid],
        userId: uid,
        fileLink: image.path,
        isDeleted: false,
        dateTime: DateTime.now(),
        deletedBy: "",
      ),
    );

    Navigator.pop(context);
  }
}
