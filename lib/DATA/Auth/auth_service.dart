import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String defaultProfilePhoto = 'https://avatars.mds.yandex.net/i?id=9a8142a64b864de7a5b2b3be826ab7e9-4935648-images-thumbs&n=13';

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
      //
      // String? fcmToken = await FirebaseMessaging.instance.getToken();
      // debugPrint(fcmToken);

      // Yeni kullanıcı bilgilerini güncelle
      await _firestore.collection('Users').doc(userCredential.user!.uid).set({
        'uuid': userCredential.user!.uid,
        'email': userCredential.user!.email,
        'imageUrl': defaultProfilePhoto,
        'name': '',
        'age': null,
        'gender': 'not selected',
        'country': 'not selected',
       // 'fcmToken': fcmToken,
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
