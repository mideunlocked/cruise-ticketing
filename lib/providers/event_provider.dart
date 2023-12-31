import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/event.dart';
import 'image_provider.dart';

class EventProvider with ChangeNotifier {
  FirebaseFirestore cloudInstance = FirebaseFirestore.instance;
  FirebaseAuth authInstance = FirebaseAuth.instance;

  final List<Event> _events = [];
  final List<Event> _recommended = [];
  final List<Event> _nearBy = [];
  final List<Event> _today = [];

  List<Event> get events {
    return [..._events];
  }

  List<Event> get recommended {
    return [..._recommended];
  }

  List<Event> get nearBy {
    return [..._nearBy];
  }

  List<Event> get today {
    return [..._today];
  }

  Future<dynamic> addEvent(Event event) async {
    var eventCollection = cloudInstance.collection("events");

    try {
      await eventCollection.add(event.toJson()).then((value) async {
        await eventCollection.doc(value.id).update({
          "id": value.id,
        });
        await AppImageProvider().uploadEventImage(
          File(event.imageUrl),
          value.id,
        );
        await cloudInstance.collection("users").doc(event.hostId).update({
          "hosted": FieldValue.arrayUnion([value.id]),
        });
      });

      return true;
    } catch (e) {
      print("error creating event: $e");
      return false;
    }
  }

  void update(Event event) {
    _events.removeWhere(
      (e) => e.id == event.id,
    );
    _events.insert(
      int.parse(event.id) - 1,
      event,
    );
  }

  void deleteEvent(String id) {
    _events.removeWhere((event) => event.id == id);
  }

  Future<DocumentSnapshot> getEvent(String eventId) async {
    try {
      DocumentSnapshot documentSnap =
          await cloudInstance.collection("events").doc(eventId).get();

      return documentSnap;
    } catch (e) {
      print("Get event error: $e");
      notifyListeners();
      return Future.error(e);
    }
  }

  Future<dynamic> saveEvent(String eventId) async {
    String? uid = authInstance.currentUser?.uid ?? "";
    try {
      await cloudInstance.collection("events").doc(eventId).update({
        "saved": FieldValue.arrayUnion([uid]),
      });

      return true;
    } catch (e) {
      print("Save event error: $e");
      return e.toString();
    }
  }

  Future<dynamic> unsaveEvent(String eventId) async {
    String? uid = authInstance.currentUser?.uid ?? "";
    try {
      await cloudInstance.collection("events").doc(eventId).update({
        "saved": FieldValue.arrayRemove([uid]),
      });

      return true;
    } catch (e) {
      print("Unsave event error: $e");
      return e.toString();
    }
  }

  Future<dynamic> getUserEvents({String userId = ""}) async {
    String uid = "";

    if (userId == "") {
      uid = authInstance.currentUser?.uid ?? "";
    } else {
      uid = userId;
    }
    try {
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot;
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await cloudInstance
          .collection("events")
          .where(
            "hostId",
            isEqualTo: uid,
          )
          .get();

      _events.clear();

      for (snapshot in querySnapshot.docs) {
        Map<String, dynamic> data = snapshot.data();

        _events.add(
          Event.fromJson(data),
        );
      }
    } catch (e) {
      print("Get user events error: $e");
      notifyListeners();
      return Future.error(e);
    }
  }

  Future<dynamic> getRecommended() async {
    try {
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot;
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await cloudInstance
          .collection("events")
          .orderBy("timestamp")
          .limit(5)
          .get();

      _recommended.clear();

      for (snapshot in querySnapshot.docs) {
        Map<String, dynamic> data = snapshot.data();

        _recommended.add(
          Event.fromJson(data),
        );
      }

      notifyListeners();
      return true;
    } catch (e) {
      print("Get recommened events error: $e");
      notifyListeners();
      return Future.error(e);
    }
  }

  Future<dynamic> getNearBy() async {
    try {
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot;
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await cloudInstance
          .collection("events")
          .orderBy("timestamp")
          .limit(5)
          .get();

      _nearBy.clear();

      for (snapshot in querySnapshot.docs) {
        Map<String, dynamic> data = snapshot.data();

        _nearBy.add(
          Event.fromJson(data),
        );
      }

      notifyListeners();
      return true;
    } catch (e) {
      print("Get near by events error: $e");
      notifyListeners();
      return Future.error(e);
    }
  }

  Future<dynamic> getToday() async {
    try {
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot;
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await cloudInstance
          .collection("events")
          .orderBy("timestamp")
          .limit(5)
          .get();

      _today.clear();

      for (snapshot in querySnapshot.docs) {
        Map<String, dynamic> data = snapshot.data();

        _today.add(
          Event.fromJson(data),
        );
      }

      notifyListeners();
      return true;
    } catch (e) {
      print("Get today events error: $e");
      notifyListeners();
      return Future.error(e);
    }
  }
}
