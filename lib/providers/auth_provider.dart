import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../helpers/encrypt_data.dart';
import '../models/users.dart';

class AuthProvider with ChangeNotifier {
  FirebaseAuth authInstance = FirebaseAuth.instance;
  FirebaseFirestore cloudInstance = FirebaseFirestore.instance;

  Future<dynamic> createUserEmailAndPassword(
    String email,
    String password,
    String fullName,
    String username,
  ) async {
    try {
      await EncryptData.encryptAES(password);

      await authInstance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        cloudInstance.collection("users").doc(value.user?.uid).set({
          "id": value.user?.uid,
          "fullName": fullName,
          "email": email,
          "phoneNumber": "",
          "username": username,
          "bio": "",
          "gender": "",
          "videoUrl": "",
          "imageUrl": "",
          "dateOfBirth": "",
          "hosted": [],
          "attended": [],
          "followers": [],
          "following": [],
          "highlights": [],
          "password": EncryptData.encrypted?.base64,
        });
      });

      notifyListeners();

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return "The account already exists for that email.";
      } else {
        print(e);
        return e.message;
      }
    } catch (e) {
      notifyListeners();

      print("Sign up error: $e");
      return e.toString();
    }
  }

  Future<dynamic> createUserInDatabase(Users user,
      {bool isSocialAuth = false}) async {
    String uid = authInstance.currentUser?.uid ?? "";
    final userCollection = cloudInstance.collection("users");

    try {
      final docCheck = await userCollection.doc(uid).get();

      if (!docCheck.exists || isSocialAuth == false) {
        await userCollection.doc(uid).set({
          "id": uid,
          "fullName": user.name,
          "email": user.email,
          "phoneNumber": user.number,
          "username": user.username,
          "bio": user.bio,
          "gender": user.gender,
          "videoUrl": user.videoUrl,
          "imageUrl": user.imageUrl,
          "dateOfBirth": user.dateOfBirth,
          "hosted": user.hosted,
          "attended": user.attended,
          "followers": user.followers,
          "following": user.following,
          "highlights": user.highlights,
          "password": isSocialAuth ? "" : EncryptData.encrypted?.base64,
        });
        authInstance.currentUser?.updateDisplayName(user.username);
      }

      return true;
    } catch (e) {
      notifyListeners();
      print("Create user error: $e");
      return Future.error(e.toString());
    }
  }

  Future<dynamic> signInUSer(
    String loginDetail,
    String password,
  ) async {
    // String? token = await FirebaseMessagingHelper().getFcmToken();

    try {
      if (loginDetail.contains(".com") != true) {
        QuerySnapshot snap = await cloudInstance
            .collection("users")
            .where("username", isEqualTo: loginDetail)
            .get();

        await authInstance.signInWithEmailAndPassword(
          email: snap.docs[0]["email"],
          password: password,
        );

        notifyListeners();
        return true;
      } else {
        await authInstance.signInWithEmailAndPassword(
          email: loginDetail,
          password: password,
        );

        notifyListeners();
        return true;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email/username.');
        return 'No user found for that email/username.';
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return 'Wrong password provided for that user.';
      } else if (e.code == "INVALID_LOGIN_CREDENTIALS") {
        print("Invalid login credentials");
        return 'Invalid login credentials. Please check credetials and try again';
      } else {
        print(e);
        return e.message;
      }
    } catch (e) {
      notifyListeners();

      print("Sign in error: $e");
      return e;
    }
  }

  Future<dynamic> resetPassword(
    String email,
  ) async {
    try {
      authInstance.sendPasswordResetEmail(email: email);

      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return 'No user found for that email.';
      } else {
        print(e);
        return e.message;
      }
    } catch (e) {
      notifyListeners();

      print("Resest password error: $e");
      return e.toString();
    }
  }

  Future<dynamic> changePassword(
      String currentPassword, String newPassword) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Re-authenticate the user with their current password.
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: currentPassword,
        );

        await user.reauthenticateWithCredential(credential);

        // If reauthentication is successful, update the password.
        await user.updatePassword(newPassword).then((value) {
          EncryptData.encryptAES(newPassword);
          cloudInstance.collection("users").doc(user.uid).update({
            "password": EncryptData.encrypted?.base64,
          });
        });

        // Password updated successfully.
        print("Password changed successfully");
        return true;
      } else {
        // User is not signed in.
        print("User not signed in.");
        return "User not signed in.";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return "The password provided is too weak.";
      } else if (e.code == "requires-recent-login") {
        print(
            "This operation is sensitive and requires recent authentication. Log in again before retrying this request.");
        return "This operation is sensitive and requires recent authentication. Log in again before retrying this request.";
      } else {
        print(e);
        return e.message;
      }
    } catch (e) {
      notifyListeners();

      print("Change password error: $e");
      return e.toString();
    }
  }

  Future<dynamic> googleSignIn(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCred =
          await authInstance.signInWithCredential(credential);

      User? user = userCred.user;

      createUserInDatabase(
        Users(
          id: user?.uid ?? "",
          bio: "",
          name: user?.displayName ?? "",
          email: user?.email ?? "",
          number: user?.phoneNumber ?? "",
          gender: "Prefer not to say",
          hosted: [],
          videoUrl: "",
          username:
              "${user?.displayName?.split(" ").first}${user?.uid.substring(0, 5)}",
          imageUrl: user?.photoURL ?? "",
          password: "",
          attended: [],
          followers: [],
          following: [],
          highlights: [],
          dateOfBirth: DateTime.now().toString(),
          saved: [],
        ),
        isSocialAuth: true,
      ).then((value) =>
          Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false));

      return true;
    } catch (e) {
      print("Google sign in error: $e");
      return e.toString();
    }
  }

  Future<dynamic> facebookSignIn(BuildContext context) async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken?.token ?? "");

      // Once signed in, return the UserCredential
      return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } catch (e) {
      print("Google sign in error: $e");
      return e.toString();
    }
  }
}
