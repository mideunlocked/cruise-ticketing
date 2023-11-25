import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

import '../models/users.dart';

class UsersProvider with ChangeNotifier {
  FirebaseAuth authInstance = FirebaseAuth.instance;
  FirebaseFirestore cloudInstance = FirebaseFirestore.instance;

  Users _userData = Users(
    password: "",
    id: "",
    bio: "",
    name: "",
    email: "",
    number: "",
    gender: "",
    hosted: [],
    videoUrl: "",
    username: "",
    imageUrl: "",
    attended: [],
    followers: [],
    following: [],
    highlights: [],
    dateOfBirth: DateTime.now().toString(),
    saved: [],
  );

  final List<Users> _users = [];

  List<dynamic> _saved = [];
  List<dynamic> _following = [];
  List<dynamic> _followers = [];

  Users get userData {
    return _userData;
  }

  List<Users> get users {
    return [..._users];
  }

  List<dynamic> get saved {
    return [..._saved];
  }

  List<dynamic> get following {
    return [..._following];
  }

  List<dynamic> get followers {
    return [..._followers];
  }

  void addUser(Users user) {
    _userData = user;
    notifyListeners();
  }

  Future<Users> getUser(String userId) async {
    try {
      DocumentSnapshot snapshot =
          await cloudInstance.collection("users").doc(userId).get();

      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

      return Users.fromJson(data);
    } catch (e) {
      print("Get user error: $e");
      return Future.error(e);
    }
  }

  Future<dynamic> updateUserDetails(Users user) async {
    final uid = authInstance.currentUser?.uid;

    try {
      await cloudInstance.collection("users").doc(uid).update({
        "fullName": user.name,
        "email": user.email,
        "phoneNumber": user.number,
        "username": user.username,
        "bio": user.bio,
        "gender": user.gender,
        "videoUrl": user.videoUrl,
        "imageUrl": user.imageUrl,
        "dateOfBirth": user.dateOfBirth,
      });
    } catch (e) {
      notifyListeners();
      print("Update user details error: $e");
      return e.toString();
    }
  }

  Future<dynamic> getCurrentUser() async {
    final uid = authInstance.currentUser?.uid;

    try {
      DocumentSnapshot snapshot =
          await cloudInstance.collection("users").doc(uid).get();

      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

      _userData = Users.fromJson(data);

      _followers = _userData.followers ?? [];
      _following = _userData.following ?? [];
      _saved = userData.saved;

      notifyListeners();
    } catch (e) {
      notifyListeners();
      print("Get current user details error: $e");
      return e.toString();
    }
  }

  Future<dynamic> saveEvent(String eventId) async {
    String? uid = authInstance.currentUser?.uid ?? "";
    try {
      await cloudInstance.collection("users").doc(uid).update({
        "saved": FieldValue.arrayUnion([eventId]),
      }).then((_) => _saved.add(eventId));

      notifyListeners();

      return true;
    } catch (e) {
      notifyListeners();
      print("User save event error: $e");
      return e.toString();
    }
  }

  Future<dynamic> unsaveEvent(String eventId) async {
    String? uid = authInstance.currentUser?.uid ?? "";

    try {
      await cloudInstance.collection("users").doc(uid).update({
        "saved": FieldValue.arrayRemove([eventId]),
      }).then((_) => _saved.remove(eventId));

      notifyListeners();

      return true;
    } catch (e) {
      notifyListeners();
      print("User unsave event error: $e");
      return e.toString();
    }
  }

  Future<dynamic> followUser(String userId) async {
    String? uid = authInstance.currentUser?.uid ?? "";

    try {
      await cloudInstance
          .collection("users")
          .doc(uid)
          .update({
            "following": FieldValue.arrayUnion([userId]),
          })
          .then((_) async =>
              await cloudInstance.collection("users").doc(userId).update({
                "followers": FieldValue.arrayUnion([userId]),
              }))
          .then((_) => _following.add(userId));

      notifyListeners();

      return true;
    } catch (e) {
      notifyListeners();
      print("Follow user error: $e");
      return e.toString();
    }
  }

  Future<dynamic> unfollowUser(String userId) async {
    String? uid = authInstance.currentUser?.uid ?? "";

    try {
      await cloudInstance
          .collection("users")
          .doc(uid)
          .update({
            "following": FieldValue.arrayRemove([userId]),
          })
          .then((_) async =>
              await cloudInstance.collection("users").doc(userId).update({
                "followers": FieldValue.arrayRemove([userId]),
              }))
          .then((_) => _following.remove(userId));

      notifyListeners();

      return true;
    } catch (e) {
      notifyListeners();
      print("Unfollow user error: $e");
      return e.toString();
    }
  }
}
