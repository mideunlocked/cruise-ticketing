import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../data.dart';
import '../../widgets/create_event_widgets/custom_add_event_text_field.dart';
import '../../widgets/create_event_widgets/text_field_title.dart';
import '../../widgets/event_screen_widgets/event_screen_title_widget.dart';
import '../../widgets/event_screen_widgets/features_tile_widget.dart';

class Step3 extends StatefulWidget {
  const Step3({
    super.key,
    required this.rulesController,
    required this.rulesNode,
    required this.getFunction,
  });

  final TextEditingController rulesController;
  final Function(List<dynamic>) getFunction;
  final FocusNode rulesNode;

  @override
  State<Step3> createState() => _Step3State();
}

class _Step3State extends State<Step3> {
  List<dynamic> pickedFeatures = [];

  var feature = eventFeatures[0];

  @override
  Widget build(BuildContext context) {
    eventFeatures.sort();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const EventScreenTitleWidget(title: "Event Details"),
        SizedBox(
          height: 5.h,
        ),
        CustomAddEventTextField(
          textInputAction: TextInputAction.newline,
          controller: widget.rulesController,
          node: widget.rulesNode,
          hint: "Set rules",
          title: "RULES",
          maxLines: 10,
        ),
        const TextFieldTitle(title: "FEATURES"),
        GridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 4.w,
            mainAxisSpacing: 4.w,
            mainAxisExtent: 5.h,
          ),
          children: eventFeatures
              .map(
                (e) => InkWell(
                  onTap: () {
                    setState(() {
                      if (pickedFeatures.contains(e)) {
                        pickedFeatures.remove(e);
                      } else {
                        pickedFeatures.add(e);
                      }
                      widget.getFunction(pickedFeatures);
                    });
                  },
                  child: FeaturesTileWidget(
                    title: e,
                    isPicked: pickedFeatures.contains(e),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
