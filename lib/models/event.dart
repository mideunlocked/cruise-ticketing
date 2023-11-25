import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cruise/helpers/date_time_formatting.dart';
import 'package:flutter/material.dart';

import 'attendee.dart';
import 'event_analysis.dart';
import 'pricing.dart';

class Event {
  final String id;
  final String name;
  final bool isValid;
  final String rules;
  final String venue;
  final String hostId;
  final DateTime date;
  final double rating;
  final String address;
  final bool isPrivate;
  final String imageUrl;
  final String videoUrl;
  final GeoPoint geoPoint;
  final TimeOfDay endTime;
  final int ticketQuantity;
  final String description;
  final Timestamp timestamp;
  final TimeOfDay startTime;
  final List<Pricing> pricing;
  final List<dynamic> features;
  final EventAnalysis analysis;
  final List<Attendee>? attendees;
  final List<dynamic> reviews;
  final List<dynamic> saved;

  const Event({
    required this.id,
    required this.name,
    required this.date,
    required this.venue,
    required this.saved,
    required this.rules,
    required this.hostId,
    required this.rating,
    required this.isValid,
    required this.reviews,
    required this.address,
    required this.pricing,
    required this.endTime,
    required this.geoPoint,
    required this.imageUrl,
    required this.videoUrl,
    required this.analysis,
    required this.features,
    required this.attendees,
    required this.isPrivate,
    required this.timestamp,
    required this.startTime,
    required this.description,
    required this.ticketQuantity,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    final List<dynamic> pricingList = json['pricing'] as List<dynamic>;
    final List<Pricing> parsedPricing = pricingList
        .map((pricingJson) =>
            Pricing.fromJson(pricingJson as Map<String, dynamic>))
        .toList();

    final List<dynamic> attendeesList = json['attendees'] as List<dynamic>;
    final List<Attendee> parsedAttendees = attendeesList
        .map((attendeeJson) =>
            Attendee.fromJson(attendeeJson as Map<String, dynamic>))
        .toList();

    return Event(
      id: json["id"] as String,
      name: json["name"] as String,
      date: DateTime.parse(json["date"].toString()),
      venue: json["venue"] as String,
      rules: json["rules"] as String,
      hostId: json["hostId"] as String,
      geoPoint: json["geoPoint"] as GeoPoint,
      rating: double.parse(json["rating"].toString()),
      isValid: json["isValid"] as bool,
      reviews: json["reviews"] as List<dynamic>,
      address: json["address"] as String,
      pricing: parsedPricing,
      endTime: DateTimeFormatting.stringToTimeOfDay(json["endTime"] as String),
      imageUrl: json["imageUrl"] as String,
      videoUrl: json["videoUrl"] as String,
      analysis:
          EventAnalysis.fromJson(json["eventAnalysis"] as Map<String, dynamic>),
      features: json["features"] as List<dynamic>,
      attendees: parsedAttendees,
      isPrivate: json["isPrivate"] as bool,
      timestamp: json["timestamp"] as Timestamp,
      startTime:
          DateTimeFormatting.stringToTimeOfDay(json["startTime"] as String),
      description: json["description"] as String,
      ticketQuantity: json["ticketQuantity"] as int,
      saved: json["saved"] as List<dynamic>,
    );
  }

  Map<String, dynamic> toJson() {
    final List<dynamic> parsedPricing = pricing.map((e) => e.toJson()).toList();
    final List<dynamic> parsedAttendees =
        attendees?.map((e) => e.toJson()).toList() ?? [];

    return {
      "id": id,
      "name": name,
      "date": date.toString(),
      "venue": venue,
      "rules": rules,
      "hostId": hostId,
      "rating": rating,
      "isValid": isValid,
      "reviews": reviews,
      "address": address,
      "pricing": parsedPricing,
      "endTime": endTime.toString(),
      "geoPoint": geoPoint,
      "imageUrl": imageUrl,
      "videoUrl": videoUrl,
      "eventAnalysis": analysis.toJson(),
      "features": features,
      "attendees": parsedAttendees,
      "isPrivate": isPrivate,
      "timestamp": Timestamp.now(),
      "startTime": startTime.toString(),
      "description": description,
      "ticketQuantity": ticketQuantity,
      "saved": [],
    };
  }
}
