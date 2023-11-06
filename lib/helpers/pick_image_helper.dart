import 'dart:io';

import 'package:flutter/material.dart';

import '../widgets/lobby_widgets/file_picker_widget.dart';

class ShowFilePicker {
  static void showFilePicker({
    required BuildContext context,
    String? lobbyId = "",
    required Function(File) getFile,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => FilePickerWidget(
        lobbyId: "",
        getFile: getFile,
      ),
    );
  }
}
