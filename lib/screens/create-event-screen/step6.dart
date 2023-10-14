import 'package:cruise/models/auto_complet_predictions.dart';
import 'package:cruise/models/place_auto_complete_response.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/env.dart';
import '../../helpers/network_utility.dart';
import '../../widgets/create_event_widgets/custom_add_event_text_field.dart';
import '../../widgets/create_event_widgets/text_field_title.dart';
import '../../widgets/event_screen_widgets/event_screen_title_widget.dart';

// ignore: must_be_immutable
class Step6 extends StatefulWidget {
  Step6({
    super.key,
    required this.venueController,
    required this.addressController,
    required this.formKey,
  });

  final TextEditingController venueController;
  TextEditingController addressController;
  final GlobalKey<FormState> formKey;

  @override
  State<Step6> createState() => _Step6State();
}

class _Step6State extends State<Step6> {
  List<AutocompletePrediction> placePredictions = [];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const EventScreenTitleWidget(title: "Venue and address"),
          SizedBox(
            height: 5.h,
          ),
          CustomAddEventTextField(
            controller: widget.venueController,
            node: FocusNode(),
            title: "VENUE",
            hint: "Enter event title",
          ),
          const TextFieldTitle(title: "Address"),
          Padding(
            padding: EdgeInsets.only(bottom: 2.h),
            child: TextFormField(
              controller: widget.addressController,
              textInputAction: TextInputAction.search,
              decoration: const InputDecoration(
                hintText: "Enter actual address",
              ),
              keyboardType: TextInputType.streetAddress,
              onChanged: (value) async {
                await placesAutoComplete(value);
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return "Address is required";
                }
                return null;
              },
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: placePredictions.length,
            itemBuilder: (ctx, index) => InkWell(
              onTap: () {
                setState(() {
                  widget.addressController.text =
                      placePredictions[index].description.toString();
                  placePredictions = [];
                });
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined),
                      SizedBox(
                        width: 3.w,
                      ),
                      SizedBox(
                          width: 75.w,
                          child:
                              Text(placePredictions[index].description ?? "")),
                    ],
                  ),
                  const Divider(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> placesAutoComplete(String query) async {
    Uri uri = Uri.https(
      "maps.googleapis.com",
      "maps/api/place/autocomplete/json",
      {
        "input": query,
        "key": googleAPIKey,
      },
    );

    String? response = await NetworkUtility.fetchUrl(uri);

    PlaceAutoCompleteResponse result =
        PlaceAutoCompleteResponse.parseAutoComplete(response ?? "");

    if (result.predictions != null) {
      setState(() {
        placePredictions = result.predictions!;
      });
    }
  }
}
