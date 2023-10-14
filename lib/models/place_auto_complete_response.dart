import 'dart:convert';

import 'package:cruise/models/auto_complet_predictions.dart';

class PlaceAutoCompleteResponse {
  final String? status;
  final List<AutocompletePrediction>? predictions;

  PlaceAutoCompleteResponse({this.status, this.predictions});

  factory PlaceAutoCompleteResponse.fromJson(Map<String, dynamic> json) {
    return PlaceAutoCompleteResponse(
      status: json["status"] as String?,
      // ignore: prefer_null_aware_operators
      predictions: json["predictions"] != null
          ? json["predictions"]
              .map<AutocompletePrediction>(
                  (json) => AutocompletePrediction.fromJson(json))
              .toList()
          : null,
    );
  }

  static PlaceAutoCompleteResponse parseAutoComplete(String responseBody) {
    final parsed = json.decode(responseBody).cast<String, dynamic>();

    return PlaceAutoCompleteResponse.fromJson(parsed);
  }
}
