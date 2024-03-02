// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class AuthService {
//   /// instance of auth
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   /// get current user
//   User? getCurrentUser() {
//     return _auth.currentUser;
//   }
//
//   /// sign in
//   Future<UserCredential> signInWithEmailAndPassword(
//       String email, String password) async {
//     try {
//       // sign user in
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//           email: email, password: password);
//
//       // save user info if it doesn't already exist
//       _firestore.collection('Users').doc(userCredential.user!.uid).set({
//         'uuid': userCredential.user!.uid,
//         'email': userCredential.user!.email,
//       });
//       return userCredential;
//     } on FirebaseAuthException catch (error) {
//       debugPrint("Login Error: $error");
//       throw SignUpException('Login Error: $error');
//     }
//   }
//
//   /// sign up
//   Future<UserCredential> signUpWithEmailAndPassword(
//       String email, String password) async {
//     try {
//       //create user
//       UserCredential userCredential = await _auth
//           .createUserWithEmailAndPassword(email: email, password: password);
//
//       /// save user info in a separate doc
//       _firestore.collection('Users').doc(userCredential.user!.uid).set({
//         'uuid': userCredential.user!.uid,
//         'email': userCredential.user!.email,
//         'imageUrl':'https://avatars.mds.yandex.net/i?id=22a6b03923e22d591b4cc37257a490e731e70c39-8377138-images-thumbs&n=13',
//         'name': '',
//         'age': null,
//         'gender': '',
//         'country': '',
//       });
//       return userCredential;
//     } on FirebaseAuthException catch (e) {
//       debugPrint("Sign Up Error: $e");
//       throw SignUpException("Sign Up Error: $e");
//     }
//   }
//
//   /// sign out
//   Future<void> signOut() async {
//     await _auth.signOut();
//   }
//
//   Future<String> fetchUserEmail(String email) async {
//     User? user = getCurrentUser();
//
//     if (user != null) {
//       DocumentSnapshot userDoc =
//           await _firestore.collection('Users').doc(user.uid).get();
//
//       if (userDoc.exists) {
//         email = userDoc['email'];
//       }
//     }
//     return email;
//   }
//
//   /// şifre sıfırlama
//   Future<void> resetPassword(String email) async {
//     try {
//       await _auth.sendPasswordResetEmail(email: email);
//       // Şifre sıfırlama e-postası gönderildi.
//     } catch (e) {
//       debugPrint("Şifre sıfırlama hatası: $e");
//       // Hata durumunda kullanıcıya bilgi verebilirsiniz.
//     }
//   }
// }
//
// class SignUpException implements Exception {
//   final String message;
//
//   SignUpException(this.message);
// }
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String defaultProfilePhoto = 'images/profile_avatar.png';

  /// get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Kullanıcı oturum açtığında mevcut verileri güncelle
  Future<void> updateUserDataOnSignIn(User user) async {
    DocumentSnapshot userDoc =
        await _firestore.collection('Users').doc(user.uid).get();

    if (userDoc.exists) {
      // Mevcut kullanıcıya ait verileri al
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

      // Kullanıcı verilerini güncelle
      await _firestore.collection('Users').doc(user.uid).set(userData);
    }
  }

  // Oturum açma (E-posta ve şifre ile)
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      // Yeni kullanıcı bilgilerini güncelle
      await updateUserDataOnSignIn(userCredential.user!);

      return userCredential;
    } on FirebaseAuthException catch (error) {
      debugPrint("Login Error: $error");
      throw SignUpException('Login Error: $error');
    }
  }

  // Oturum kayıt olma (E-posta ve şifre ile)
  Future<UserCredential> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Yeni kullanıcı bilgilerini güncelle
      await _firestore.collection('Users').doc(userCredential.user!.uid).set({
        'uuid': userCredential.user!.uid,
        'email': userCredential.user!.email,
        'imageUrl': defaultProfilePhoto,
        'name': '',
        'age': null,
        'gender': 'not selected',
        'country': 'not selected',
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      debugPrint("Sign Up Error: $e");
      throw SignUpException("Sign Up Error: $e");
    }
  }


  // Oturumu kapat
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Şifreyi sıfırla
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      // Şifre sıfırlama e-postası gönderildi.
    } catch (e) {
      debugPrint("Şifre sıfırlama hatası: $e");
      // Hata durumunda kullanıcıya bilgi verebilirsiniz.
    }
  }
}

class SignUpException implements Exception {
  final String message;

  SignUpException(this.message);
}
