import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/create_event_widgets/custom_add_event_text_field.dart';
import '../../widgets/create_event_widgets/select_gener_widget.dart';
import '../../widgets/event_screen_widgets/event_screen_title_widget.dart';

class Step1 extends StatefulWidget {
  const Step1({
    super.key,
    required this.nameController,
    required this.descriptionController,
    required this.descriptionNode,
    required this.nameNode,
    required this.currentStep,
    required this.formKey,
  });

  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final GlobalKey<FormState> formKey;
  final FocusNode descriptionNode;
  final FocusNode nameNode;
  final int currentStep;

  @override
  State<Step1> createState() => _Step1State();
}

class _Step1State extends State<Step1> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const EventScreenTitleWidget(title: "Basic Info"),
          SizedBox(
            height: 5.h,
          ),
          CustomAddEventTextField(
            controller: widget.nameController,
            node: widget.nameNode,
            title: "TITLE",
            hint: "Enter event title",
            maxLenght: 25,
          ),
          CustomAddEventTextField(
            controller: widget.descriptionController,
            node: widget.descriptionNode,
            title: "DESCRIPTION",
            hint: "Enter event description",
            maxLines: 10,
          ),
          const SelectGenerWidget(),
        ],
      ),
    );
  }
}
