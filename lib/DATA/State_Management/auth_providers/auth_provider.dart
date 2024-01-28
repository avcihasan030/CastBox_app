import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final authProvider = Provider<AuthProvider>((ref) {
  return AuthProvider(ref.read);
});

final userProvider = StreamProvider<User?>((ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
});

class AuthProvider {
  final _read;

  AuthProvider(this._read);

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _read(firebaseAuthProvider)
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print("Login Hatası: $e");
      return null;
    }
  }

  Future<User?> registerWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      UserCredential userCredential = await _read(firebaseAuthProvider)
          .createUserWithEmailAndPassword(email: email, password: password);

      // Kullanıcı adını güncellemek için
      await userCredential.user!.updateDisplayName(name);

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print("Registration Hatası: $e");
      return null;
    }
  }
}