/*
 * Copyright (c) FutureSoft 2021
 * Author: Daham
 *
 */

import 'package:firebase_auth/firebase_auth.dart';

class Authentication{
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> getLoggedUser() async {
    final User? user = auth.currentUser;
    print("get logged user:-- ${user.toString()}");
    if (user == null) return null;
    return user;
  }

  Future<UserCredential?> login({String? email, String? password}) async {
    UserCredential? result;
    try {
      result = await auth.signInWithEmailAndPassword(
        email: email ?? "",
        password: password ?? "",
      );
      print("Login:--");
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
    }
    return result;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<UserCredential?> registerUser({String? email, String? password}) async {
    UserCredential? result;
    try {
      result = await auth.createUserWithEmailAndPassword(
        email: email ?? "",
        password: password ?? "",
      );
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
    }
    return result;
  }
}