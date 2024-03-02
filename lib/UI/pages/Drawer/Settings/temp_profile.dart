import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/DATA/Auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Kullanıcının bilgileri
  String? profilePhoto =
      'https://avatars.mds.yandex.net/i?id=22a6b03923e22d591b4cc37257a490e731e70c39-8377138-images-thumbs&n=13';
  //'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/e7236087-24e0-41dc-9886-0cc0e6352edb/dffep1w-196d5430-cb72-40af-9d06-9aa0691551af.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcL2U3MjM2MDg3LTI0ZTAtNDFkYy05ODg2LTBjYzBlNjM1MmVkYlwvZGZmZXAxdy0xOTZkNTQzMC1jYjcyLTQwYWYtOWQwNi05YWEwNjkxNTUxYWYuanBnIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.utF89BRgsoiA57vT33kdZknxKF21HayN7RZtyKcVzlE';
  String? ad = 'not specified';
  String email = '';
  String? ulke = 'not specified';
  int? yas;
  String? cinsiyet = 'not specified';

  // Bilgileri güncellemek için controller'lar
  TextEditingController? adController;
  TextEditingController? emailController;
  TextEditingController? ulkeController;
  TextEditingController? yasController;
  TextEditingController? cinsiyetController;

  final AuthService _authService = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _imagePicker = ImagePicker();

  Future<void> fetchUserEmail() async {
    User? user = _authService.getCurrentUser();

    if (user != null) {
      DocumentSnapshot userDoc =
      await _firestore.collection('Users').doc(user.uid).get();

      if (userDoc.exists) {
        setState(() {
          email = userDoc['email'];
        });
      }
    }
  }

  Future<void> fetchUserProfile() async {
    try {
      User? user = _authService.getCurrentUser();
      if (user != null) {
        DocumentSnapshot userDoc =
        await _firestore.collection('Users').doc(user.uid).get();

        if (userDoc.exists) {
          setState(() {
            // Firestore'dan kullanıcı bilgilerini al
            profilePhoto = userDoc['imageUrl'] ?? profilePhoto;
            ad = userDoc['name'] ?? ad;
            //email = userDoc['email'] ?? email; // Email bilgisini al
            ulke = userDoc['country'] ?? ulke;
            yas = userDoc['age'] ?? yas;
            cinsiyet = userDoc['gender'] ?? cinsiyet;
          });
        }
      }
    } catch (e) {
      debugPrint(
          'Firestore\'dan kullanıcı bilgilerini alırken hata oluştu: $e');
    }
  }

  void updateUserProfile(String uid, Map<String, dynamic> data) {
    // Güncellenmiş alanları saklamak için bir harita oluşturun
    Map<String, dynamic> updatedData = {};

    // Veritabanından kullanıcının mevcut verilerini alın
    DocumentReference userRef = FirebaseFirestore.instance.collection('Users').doc(uid);

    // Ad alanını güncelleyin
    if (data.containsKey('name')) {
      updatedData['name'] = data['name'];
    } else {
      updatedData['name'] = ad;
    }

    // Ülke alanını güncelleyin
    if (data.containsKey('country')) {
      updatedData['country'] = data['country'];
    } else {
      updatedData['country'] = ulke;
    }

    // Yaş alanını güncelleyin
    if (data.containsKey('age')) {
      updatedData['age'] = data['age'];
    } else {
      updatedData['age'] = yas;
    }

    // Cinsiyet alanını güncelleyin
    if (data.containsKey('gender')) {
      updatedData['gender'] = data['gender'];
    } else {
      updatedData['gender'] = cinsiyet;
    }

    // Fotoğraf URL'sini güncelleyin
    updatedData['imageUrl'] = profilePhoto;

    // Firestore'daki verileri güncelle
    userRef.update(updatedData).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profil güncellendi')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hata: $error')),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUserEmail();
    fetchUserProfile();
    adController = TextEditingController();
    emailController = TextEditingController(text: email);
    ulkeController = TextEditingController();
    yasController = TextEditingController();
    cinsiyetController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Sayfası'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    // Profil fotoğrafına tıklandığında büyük bir fotoğrafı göster
                    showProfilePhotoDialog(profilePhoto!);
                  },
                  onLongPress: () {
                    changeProfilePhotoDialog(profilePhoto!);
                  },
                  child: Hero(
                    tag: 'profilePhoto',
                    child: CircleAvatar(
                      radius: 54,
                      foregroundImage: NetworkImage(profilePhoto!),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Ad Bilgisi
              buildInfoTile(
                'Ad',
                ad!,
                adController!,
              ),

              // Email Bilgisi
              buildInfoTile(
                'Email',
                email,
                emailController!,
              ),

              // Ülke Bilgisi
              buildInfoTile(
                'Ülke',
                ulke!,
                ulkeController!,
              ),

              // Yaş Bilgisi
              buildInfoTile(
                'Yaş',
                yas?.toString() ?? 'Undefined',
                yasController!,
              ),

              // Cinsiyet Bilgisi
              buildInfoTile(
                'Cinsiyet',
                cinsiyet!,
                cinsiyetController!,
              ),

              const SizedBox(height: 16),

              Center(
                child: ElevatedButton(
                    onPressed: () {
                      updateUserProfile(_authService.getCurrentUser()!.uid, {
                        'name': ad,
                        'country': ulke,
                        'age': yas,
                        'gender': cinsiyet,
                        'imageUrl': profilePhoto,
                      });
                    },
                    child: const Text("Profil Bilgilerini Güncelle")),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoTile(
      String label, String value, TextEditingController controller) {
    return ListTile(
      leading: const CircleAvatar(
        radius: 24, // Adjust the size as needed
        child: Icon(Icons.person), // You can use any icon or image here
      ),
      title: Text(label),
      subtitle: Text(value),
      trailing: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () {
          showEditDialog(label, controller);
        },
      ),
    );
  }

  void showEditDialog(String label, TextEditingController controller) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Bilgi Güncelle'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(labelText: label),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('İptal'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  // Kullanıcının girdiği yeni bilgiyi güncelle
                  if (label == 'Ad') {
                    ad = controller.text;
                  } else if (label == 'Ülke') {
                    ulke = controller.text;
                  } else if (label == 'Yaş') {
                    yas = int.tryParse(controller.text);
                  } else if (label == 'Cinsiyet') {
                    cinsiyet = controller.text;
                  }

                  Navigator.pop(context);
                });
              },
              child: const Text('Kaydet'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _getImageFromGallery() async {
    final XFile? image =
    await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        profilePhoto = image.path;
      });
    }
  }

  void showProfilePhotoDialog(String imageUrl) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            width: 300,
            height: 300,
            child: Hero(
              tag: 'profilePhoto',
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }

  void changeProfilePhotoDialog(String imageUrl) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Profil Fotoğrafını Değiştir'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: const Text('Fotoğrafı Galeriden Seç'),
                  onTap: () {
                    Navigator.pop(context);
                    _getImageFromGallery();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
