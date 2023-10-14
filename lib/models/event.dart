import 'package:flutter/material.dart';

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
  final TimeOfDay endTime;
  final int ticketQuantity;
  final String description;
  final DateTime timestamp;
  final TimeOfDay startTime;
  final List<Pricing> pricing;
  final List<dynamic> features;
  final EventAnalysis analysis;
  final List<dynamic> attendees;
  final Map<String, dynamic> latlng;

  const Event({
    required this.id,
    required this.name,
    required this.date,
    required this.venue,
    required this.rules,
    required this.hostId,
    required this.latlng,
    required this.rating,
    required this.isValid,
    required this.address,
    required this.pricing,
    required this.endTime,
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
}
