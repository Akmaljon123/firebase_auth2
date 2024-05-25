import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth2/my_app/setup.dart';
import 'package:firebase_auth2/pages/home_page.dart';
import 'package:firebase_auth2/services/util_service.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static GoogleSignIn googleSignIn = GoogleSignIn();

  static Future<User?> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        log('Google sign-in was aborted by the user.');
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await auth.signInWithCredential(credential);
      final User? userAuth = userCredential.user;

      if (userAuth != null) {
        final DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection("users")
            .doc(userAuth.email)
            .get();

        if (userDoc.exists) {
          if (context.mounted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
                  (route) => false,
            );
          }
          return userAuth;
        } else {
          await auth.signOut();
          await googleSignIn.signOut();

          if (context.mounted) {
            Utils.fireSnackBar("You are not registered in our system", context);
          }
        }
      } else {
        log('User authentication failed. userAuth is null.');
      }
    } catch (e) {
      if (context.mounted) {
        log("Error during Google sign-in: $e");
        Utils.fireSnackBar("Error: $e", context);
      }
      return null;
    }
    return null;
  }

  static Future<User?> registerUser(
      {required String name,
      required String email,
      required String password}) async {
    UserCredential user = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    await user.user?.updateDisplayName(name);

    if (user.user != null) {
      Map<String, dynamic> userData = {
        'uid': user.user!.uid,
        'name': name,
        'email': email,
      };
      await collectionReference.add(userData);
      return user.user;
    } else {
      return null;
    }
  }

  static Future<User?> loginUser(
      {required String email, required String password}) async {
    UserCredential user =
        await auth.signInWithEmailAndPassword(email: email, password: password);

    if (user.user != null) {

      return user.user;
    } else {
      return null;
    }
  }

  static Future<void> logout() async {
    await auth.signOut();
    await googleSignIn.signOut();
  }

  static Future<void> delete() async {
    User? user = auth.currentUser;

    if (user != null) {
      await user.delete();
      await googleSignIn.disconnect();
    }
  }
}

// static Future<User?> signInWithGoogle(BuildContext context) async {
// try {
// final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
//
// if (googleUser == null) {
// log('Google sign-in was aborted by the user.');
// return null;
// }
//
// final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//
// final AuthCredential credential = GoogleAuthProvider.credential(
// accessToken: googleAuth.accessToken,
// idToken: googleAuth.idToken,
// );
//
// final UserCredential userCredential = await auth.signInWithCredential(credential);
// final User? userAuth = userCredential.user;
//
// if (userAuth != null) {
// final DocumentSnapshot userDoc = await FirebaseFirestore.instance
//     .collection("users")
//     .doc(userAuth.uid)
//     .get();
//
// if (userDoc.exists) {
// if (context.mounted) {
// Navigator.pushAndRemoveUntil(
// context,
// MaterialPageRoute(builder: (context) => const HomePage()),
// (route) => false,
// );
// }
// return userAuth;
// } else {
// await auth.signOut();
// await googleSignIn.signOut();
//
// if (context.mounted) {
// Utils.fireSnackBar("You are not registered in our system", context);
// }
// }
// } else {
// log('User authentication failed. userAuth is null.');
// }
// } catch (e) {
// if (context.mounted) {
// log("Error during Google sign-in: $e");
// Utils.fireSnackBar("Error: $e", context);
// }
// return null;
// }
// return null;
// }
