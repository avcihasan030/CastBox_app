import 'dart:io';

import 'package:final_year_project/DATA/Notification/notification_service.dart';
import 'package:final_year_project/DATA/Profile/user_profile_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UserProfileService _profileService = UserProfileService();
  late Map<String, dynamic> _userData = {};
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  dynamic _imageFile;

  AssetImage defaultProfilePhotoUrl =
      const AssetImage('images/profile_avatar.png');

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    final userData = await _profileService.getUserProfileData();
    setState(() {
      _userData = userData;
      _nameController.text = userData['name'] ?? '';
      _countryController.text = userData['country'] ?? '';
      _ageController.text = userData['age']?.toString() ?? '';
      _genderController.text = userData['gender'] ?? '';
      dynamic imageUrl = userData['imageUrl'];
      if (imageUrl is String && imageUrl.isNotEmpty) {
        _imageFile = imageUrl;
      } else if (imageUrl is File) {
        _imageFile = imageUrl;
      }
    });
  }

  Future<void> _updateUserProfile() async {
    await _profileService.updateUserProfile({
      'name': _nameController.text.trim(),
      'country': _countryController.text.trim(),
      'age': int.tryParse(_ageController.text.trim()) ?? 0,
      'gender': _genderController.text.trim(),
      //'imageUrl': _imageFile ?? defaultProfilePhotoUrl,
    });
    await NotificationService.showNotification(
        title: 'CastBox Profile Setting',
        body: 'Your profile changes saved successfully!',
        payload: 'This is a payload message');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profil güncellendi')),
    );
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
                    if (_imageFile != null) {
                      showProfilePhotoDialog(_imageFile);
                    }
                  },
                  onLongPress: () {
                    changeProfilePhotoDialog();
                  },
                  child: _displayProfilePhoto(_imageFile),
                ),
              ),
              const SizedBox(height: 16),
              // Ad Bilgisi
              buildInfoTile('Ad', _userData['name'] ?? '', _nameController),

              // Email bilgisi
              buildInfoTile('Email', _userData['email'] ?? '', null),

              // Ülke Bilgisi
              buildInfoTile(
                  'Ülke', _userData['country'] ?? '', _countryController),

              // Yaş Bilgisi
              buildInfoTile(
                  'Yaş', _userData['age']?.toString() ?? '', _ageController),

              // Cinsiyet Bilgisi
              buildInfoTile(
                  'Cinsiyet', _userData['gender'] ?? '', _genderController),

              const SizedBox(height: 16),

              Center(
                child: ElevatedButton(
                  onPressed: _updateUserProfile,
                  child: const Text("Profil Bilgilerini Güncelle"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoTile(
      String label, String value, TextEditingController? controller) {
    return ListTile(
      leading: const CircleAvatar(
        radius: 24, // Adjust the size as needed
        child: Icon(Icons.person), // You can use any icon or image here
      ),
      title: Text(label),
      subtitle: Text(value),
      trailing: controller != null
          ? IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                showEditDialog(label, controller);
              },
            )
          : null,
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
                    _userData['name'] = controller.text;
                  } else if (label == 'Ülke') {
                    _userData['country'] = controller.text;
                  } else if (label == 'Yaş') {
                    _userData['age'] = int.tryParse(controller.text) ?? 0;
                  } else if (label == 'Cinsiyet') {
                    _userData['gender'] = controller.text;
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

  // void showProfilePhotoDialog(dynamic imageFile) {
  //   if (imageFile is File) {
  //     showDialog(
  //       context: context,
  //       builder: (context) {
  //         return Dialog(
  //           child: SizedBox(
  //             width: 300,
  //             height: 300,
  //             child: Hero(
  //               tag: 'profilePhoto',
  //               child: Image.file(
  //                 imageFile,
  //                 fit: BoxFit.cover,
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //     );
  //   } else if (imageFile is String && imageFile.isNotEmpty) {
  //     showDialog(
  //       context: context,
  //       builder: (context) {
  //         return Dialog(
  //           child: SizedBox(
  //             width: 300,
  //             height: 300,
  //             child: Hero(
  //               tag: 'profilePhoto',
  //               child: Image.asset(
  //                 imageFile,
  //                 fit: BoxFit.cover,
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //     );
  //   }
  // }
  void showProfilePhotoDialog(dynamic imageFile) {
    if (imageFile is File) {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: SizedBox(
              width: 300,
              height: 300,
              child: Hero(
                tag: 'profilePhoto',
                child: Image.file(
                  imageFile,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      );
    } else if (imageFile is String && imageFile.isNotEmpty) {
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
                  imageFile,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      );
    }
  }

  void changeProfilePhotoDialog() async {
    final XFile? pickedFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      setState(() {
        _imageFile = imageFile;
        uploadImage();
      });
    }
  }

  Future<void> uploadImage() async {
    if (_imageFile != null) {
      await _profileService.uploadAndUpdateFirestore(_imageFile);
    } else {
      debugPrint("Lütfen bir resim seçin");
    }
  }

  // Widget _displayProfilePhoto(dynamic imageFile) {
  //   if (imageFile is File) {
  //     return Hero(
  //         tag: 'profilePhoto',
  //         child: CircleAvatar(
  //           radius: 54,
  //           backgroundImage: FileImage(imageFile),
  //         ));
  //   } else if (imageFile is String && imageFile.isNotEmpty) {
  //     return Hero(
  //       tag: 'profilePhoto',
  //       child: CircleAvatar(
  //         radius: 54,
  //         backgroundImage: AssetImage(imageFile),
  //       ),
  //     );
  //   } else {
  //     return Hero(
  //       tag: 'profilePhoto',
  //       child: CircleAvatar(
  //         radius: 54,
  //         backgroundImage: defaultProfilePhotoUrl,
  //       ),
  //     );
  //   }
  // }
  Widget _displayProfilePhoto(dynamic imageFile) {
    if (imageFile is File) {
      return Hero(
          tag: 'profilePhoto',
          child: CircleAvatar(
            radius: 54,
            backgroundImage: FileImage(imageFile),
          ));
    } else if (imageFile is String && imageFile.isNotEmpty) {
      return Hero(
        tag: 'profilePhoto',
        child: CircleAvatar(
          radius: 54,
          backgroundImage: NetworkImage(imageFile),
        ),
      );
    } else {
      return Hero(
        tag: 'profilePhoto',
        child: CircleAvatar(
          radius: 54,
          backgroundImage: defaultProfilePhotoUrl,
        ),
      );
    }
  }
}
