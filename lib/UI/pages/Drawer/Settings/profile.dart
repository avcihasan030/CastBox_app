import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/DATA/Auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Kullanıcının bilgileri
  String profilePhoto =
      'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/e7236087-24e0-41dc-9886-0cc0e6352edb/dffep1w-196d5430-cb72-40af-9d06-9aa0691551af.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcL2U3MjM2MDg3LTI0ZTAtNDFkYy05ODg2LTBjYzBlNjM1MmVkYlwvZGZmZXAxdy0xOTZkNTQzMC1jYjcyLTQwYWYtOWQwNi05YWEwNjkxNTUxYWYuanBnIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.utF89BRgsoiA57vT33kdZknxKF21HayN7RZtyKcVzlE';
  String ad = "John Doe";
  String email = "";
  String ulke = "USA";
  int? yas;
  String? cinsiyet;

  // Bilgileri güncellemek için controller'lar
  TextEditingController adController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ulkeController = TextEditingController();
  TextEditingController yasController = TextEditingController();
  TextEditingController cinsiyetController = TextEditingController();

  final AuthService _authService = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  @override
  void initState() {
    super.initState();
    fetchUserEmail();
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
              //Profil Fotoğrafı
              // const Align(
              //   alignment: Alignment.center,
              //   child: CircleAvatar(
              //     radius: 54,
              //     foregroundImage: NetworkImage(
              //         'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/e7236087-24e0-41dc-9886-0cc0e6352edb/dffep1w-196d5430-cb72-40af-9d06-9aa0691551af.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcL2U3MjM2MDg3LTI0ZTAtNDFkYy05ODg2LTBjYzBlNjM1MmVkYlwvZGZmZXAxdy0xOTZkNTQzMC1jYjcyLTQwYWYtOWQwNi05YWEwNjkxNTUxYWYuanBnIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.utF89BRgsoiA57vT33kdZknxKF21HayN7RZtyKcVzlE'),
              //   ),
              // ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     GestureDetector(
              //       onTap: () {
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             builder: (context) => PhotoViewScreen(
              //               imageUrl:
              //               'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/e7236087-24e0-41dc-9886-0cc0e6352edb/dffep1w-196d5430-cb72-40af-9d06-9aa0691551af.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcL2U3MjM2MDg3LTI0ZTAtNDFkYy05ODg2LTBjYzBlNjM1MmVkYlwvZGZmZXAxdy0xOTZkNTQzMC1jYjcyLTQwYWYtOWQwNi05YWEwNjkxNTUxYWYuanBnIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.utF89BRgsoiA57vT33kdZknxKF21HayN7RZtyKcVzlE',
              //               heroTag: 'profile_photo',
              //             ),
              //           ),
              //         );
              //       },
              //       child: Hero(
              //         tag: 'profile_photo',
              //         child: CircleAvatar(
              //           radius: 54,
              //           foregroundImage: NetworkImage(
              //               'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/e7236087-24e0-41dc-9886-0cc0e6352edb/dffep1w-196d5430-cb72-40af-9d06-9aa0691551af.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcL2U3MjM2MDg3LTI0ZTAtNDFkYy05ODg2LTBjYzBlNjM1MmVkYlwvZGZmZXAxdy0xOTZkNTQzMC1jYjcyLTQwYWYtOWQwNi05YWEwNjkxNTUxYWYuanBnIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.utF89BRgsoiA57vT33kdZknxKF21HayN7RZtyKcVzlE'),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    // Profil fotoğrafına tıklandığında büyük bir fotoğrafı göster
                    showProfilePhotoDialog(profilePhoto);
                  },
                  child: Hero(
                    tag: 'profilePhoto',
                    child: CircleAvatar(
                      radius: 54,
                      foregroundImage: NetworkImage(profilePhoto),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Ad Bilgisi
              buildInfoTile(
                'Ad',
                ad,
                adController,
              ),

              // Email Bilgisi
              buildInfoTile(
                'Email',
                email.isNotEmpty ? email : "john.doe@example.com",
                emailController,
              ),

              // Ülke Bilgisi
              buildInfoTile(
                'Ülke',
                ulke,
                ulkeController,
              ),

              // Yaş Bilgisi
              buildInfoTile(
                'Yaş',
                yas?.toString() ?? 'Belirtilmemiş',
                yasController,
              ),

              // Cinsiyet Bilgisi
              buildInfoTile(
                'Cinsiyet',
                cinsiyet ?? 'Belirtilmemiş',
                cinsiyetController,
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
                    yas = int.tryParse(controller.text)!;
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
}
