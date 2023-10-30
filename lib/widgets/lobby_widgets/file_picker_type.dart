import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../screens/lobby_screens/lobby_view_send_image.dart';

class FilePickerType extends StatefulWidget {
  const FilePickerType({
    super.key,
    required this.iconUrl,
    required this.title,
    required this.lobbyId,
    required this.getFile,
  });

  final Function(File)? getFile;
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

    setState(() {
      widget.getFile!(
        File(
          pickedImage?.path ?? XFile("").path,
        ),
      );
    });

    if (widget.lobbyId.isNotEmpty) {
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
    } else {
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }
}
