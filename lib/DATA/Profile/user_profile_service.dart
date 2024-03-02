import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserProfileService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _storage = FirebaseStorage.instance;

  Future<void> updateUserProfile(Map<String, dynamic> userData) async {
    User? user = _auth.currentUser;
    if (user != null) {
      String uid = user.uid;
      DocumentReference userRef = _firestore.collection('Users').doc(uid);
      await userRef.set(userData, SetOptions(merge: true));
    }
  }

  Future<Map<String, dynamic>> getUserProfileData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      String uid = user.uid;
      DocumentSnapshot<Map<String, dynamic>> userDoc =
          await _firestore.collection('Users').doc(uid).get();
      return userDoc.data() ?? {};
    }
    return {};
  }

  Future<void> uploadAndUpdateFirestore(File imageFile) async {
    User? user = _auth.currentUser;
    if (user != null) {
      String uid = user.uid;
      String fileExtension = imageFile.path.split('.').last;
      String fileName = '$uid.$fileExtension';

      try {
        /// profil resmini firebase storage'a yükle
        UploadTask uploadTask =
            _storage.ref('images/$fileName').putFile(imageFile);
        TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);

        /// Profil fotoğrafının URL'sini al
        String downloadURL = await snapshot.ref.getDownloadURL();

        /// Firestore'dan kullanıcının belgesini al
        DocumentReference userDocRef = _firestore.collection('Users').doc(uid);

        /// Kullanıcının belgesindeki imageUrl alanını güncelle
        await userDocRef
            .set({'imageUrl': downloadURL}, SetOptions(merge: true));
      } catch (e) {
        print("Hata $e");
      }
    } else {
      print("Kullanıcı oturumu açmamış.");
    }
  }
}
