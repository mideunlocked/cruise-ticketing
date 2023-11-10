import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'file_picker_type.dart';

class FilePickerWidget extends StatelessWidget {
  const FilePickerWidget({
    super.key,
    required this.lobbyId,
    required this.getFile,
  });

  final String lobbyId;
  final Function(File) getFile;

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
            getFile: getFile,
          ),
          FilePickerType(
            title: "Gallery",
            iconUrl: "image",
            lobbyId: lobbyId,
            getFile: getFile,
          ),
        ],
      ),
    );
  }
}
