import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/create_event_widgets/text_field_title.dart';
import '../../widgets/event_screen_widgets/event_screen_title_widget.dart';

class Step2 extends StatefulWidget {
  const Step2({
    super.key,
    required this.getFunction,
  });

  final Function(File) getFunction;

  @override
  State<Step2> createState() => _Step2State();
}

class _Step2State extends State<Step2> {
  File? eventImage;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var primaryColor = of.primaryColor;

    // bool checkMode =
    //     MediaQuery.platformBrightnessOf(context) == Brightness.light;

    Color color = Colors.black26;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const EventScreenTitleWidget(title: "Event Image/Banner"),
        SizedBox(
          height: 5.h,
        ),
        const TextFieldTitle(title: "Image/Banner"),
        eventImage != null && File(eventImage!.path).existsSync()
            ? ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  eventImage ?? File(""),
                  height: 50.h,
                  width: 100.w,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const SizedBox(),
                ),
              )
            : const SizedBox(),
        SizedBox(
          height: 2.h,
        ),
        InkWell(
          onTap: () => pickImage(),
          child: Container(
            height: 7.h,
            width: 100.w,
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.file_upload_outlined,
                  color: color,
                ),
                SizedBox(
                  width: 2.w,
                ),
                Text(
                  "Upload image",
                  style: of.textTheme.bodyMedium?.copyWith(
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 75,
    );

    if (pickedImage == null) {
      return;
    }

    setState(() {
      eventImage = File(pickedImage.path);
      widget.getFunction(eventImage!);
    });
    print(eventImage?.path);
  }
}
