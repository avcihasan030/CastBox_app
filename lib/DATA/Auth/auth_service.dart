import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  /// instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  /// sign in
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      // sign user in
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      // save user info if it doesn't already exist
      _firestore.collection('Users').doc(userCredential.user!.uid).set({
        'uuid': userCredential.user!.uid,
        'email': userCredential.user!.email,
      });
      return userCredential;
    } on FirebaseAuthException catch (error) {
      debugPrint("Login Error: $error");
      throw SignUpException('Login Error: $error');
    }
  }

  /// sign up
  Future<UserCredential> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      //create user
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      /// save user info in a separate doc
      _firestore.collection('Users').doc(userCredential.user!.uid).set({
        'uuid': userCredential.user!.uid,
        'email': userCredential.user!.email,
      });
      return userCredential;
    } on FirebaseAuthException catch (e) {
      debugPrint("Sign Up Error: $e");
      throw SignUpException("Sign Up Error: $e");
    }
  }

  /// sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<String> fetchUserEmail(String email) async {
    User? user = getCurrentUser();

    if (user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('Users').doc(user.uid).get();

      if (userDoc.exists) {
        email = userDoc['email'];
      }
    }
    return email;
  }

  /// şifre sıfırlama
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      // Şifre sıfırlama e-postası gönderildi.
    } catch (e) {
      print("Şifre sıfırlama hatası: $e");
      // Hata durumunda kullanıcıya bilgi verebilirsiniz.
    }
  }
}

class SignUpException implements Exception {
  final String message;

  SignUpException(this.message);
}
