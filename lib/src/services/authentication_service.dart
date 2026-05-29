import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationService {
  AuthenticationService._();

  static final AuthenticationService instance = AuthenticationService._();

  bool get isAuthenticated => FirebaseAuth.instance.currentUser != null;
  User? get userInfo => FirebaseAuth.instance.currentUser;
  String? get userName => userInfo?.displayName;

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      // Create user with email and password
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Automatically sign in the user after successful registration
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userInfo!.updateDisplayName(name);

      // Save user info to Firestore after create account
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userInfo!.uid)
          .set({
            'uid': userInfo!.uid,
            'email': email,
            'name': name,
            'createdAt': DateTime.now(),
          });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      if (!context.mounted) return;
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    } catch (e) {
      rethrow;
    }
  }
}
