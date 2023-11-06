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
  );

  final List<Users> _users = [];

  Users get userData {
    return _userData;
  }

  List<Users> get users {
    return [..._users];
  }

  void addUser(Users user) {
    _userData = user;
    notifyListeners();
  }

  Users getUser(String userId) {
    Users? user;
    user = _users.firstWhere((e) => e.id == userId);

    return user;
  }

  List<Users> searchUsers(String keyword) {
    List<Users>? newUsers;

    _users.retainWhere((e) {
      if (e.name.toLowerCase() == keyword ||
          e.username.toLowerCase() == keyword) {
        return true;
      }
      return false;
    });

    newUsers = _users;

    notifyListeners();

    return newUsers;
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

      notifyListeners();
    } catch (e) {
      notifyListeners();
      print("Get current user details error: $e");
      return e.toString();
    }
  }
}
