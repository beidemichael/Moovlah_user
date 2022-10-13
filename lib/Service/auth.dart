// ignore_for_file: unused_local_variable, avoid_print, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:moovlah_user/Service/Database.dart';
import 'package:provider/provider.dart';
import '../Models/OrderModel.dart';
import '../Models/models.dart';

class AuthServices {
  static SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: const TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }

  Future<void> getFirebaseUser() async {}

  UserAuth? userFromFirebaseUser(User? user) {
    return user != null ? UserAuth(uid: user.uid) : null;
  }

  Stream<UserAuth?> get user {
    return FirebaseAuth.instance
        .authStateChanges()
        //.map((FirebaseUser user)=>_userFromFirebaseUser(user)) same as the code below
        .map(userFromFirebaseUser);
  }

  static Future<FirebaseApp> initializeFirebase({
    required BuildContext context,
  }) async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  static signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static signUpEmailAndPassword({
    required BuildContext context,
    required String userName,
    required String phoneNumber,
    required String emailAddress,
    required String password,
    required String type,
    required String businessName,
  }) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      Provider.of<Order>(context, listen: false).changeScreen('welcome');
     var userUid = await credential.user?.uid;

      await DatabaseService().newUserData(userName, phoneNumber, emailAddress,
          password, type, userUid.toString(), businessName);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            duration: const Duration(seconds: 2),
            elevation: 5,
            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Text(
                  'The password provided is too weak.',
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 18.0,
                      fontWeight: FontWeight.w300),
                ),
              ],
            )));
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            duration: const Duration(seconds: 2),
            elevation: 5,
            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Text(
                  'The account already exists for that email.',
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 18.0,
                      fontWeight: FontWeight.w300),
                ),
              ],
            )));
      }
    } catch (e) {
      print(e);
    }
  }

  static signInEmailAndPassword(
      {required BuildContext context,
      required String emailAddress,
      required String password}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      Provider.of<Order>(context, listen: false).changeScreen('welcome');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            duration: const Duration(seconds: 2),
            elevation: 5,
            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Text(
                  'No user found for that email.',
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 18.0,
                      fontWeight: FontWeight.w300),
                ),
              ],
            )));
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            duration: const Duration(seconds: 2),
            elevation: 5,
            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Text(
                  'Wrong password provided for that user.',
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 18.0,
                      fontWeight: FontWeight.w300),
                ),
              ],
            )));
      }
    }
  }
}
