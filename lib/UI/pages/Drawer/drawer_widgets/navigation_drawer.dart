import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:final_year_project/DATA/Auth/auth_service.dart';
import 'package:final_year_project/DATA/Profile/user_profile_service.dart';
import 'package:final_year_project/UI/utils/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigationDrawerWidget extends ConsumerStatefulWidget {
  const NavigationDrawerWidget({super.key});

  @override
  ConsumerState createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState
    extends ConsumerState<NavigationDrawerWidget> {
  dynamic profileImage;
  String? name = '';

  final UserProfileService _userProfileService = UserProfileService();

  @override
  void initState() {
    super.initState();
    _fetchUserEmailAndImage();
  }

  Future<void> _fetchUserEmailAndImage() async {
    final userData = await _userProfileService.getUserProfileData();
    setState(() {
      name = userData['name'] ?? '*****';
      dynamic imageUrl = userData['imageUrl'];
      if (imageUrl is String && imageUrl.isNotEmpty) {
        profileImage = imageUrl;
      } else if (imageUrl is File) {
        profileImage = imageUrl;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: ListTile(
                      leading: _buildProfileImage(),
                      title: Text(name!),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      TextUtils.mainTitle,
                      style: const TextStyle(letterSpacing: 1),
                    ).tr(),
                    leading: const Icon(Icons.search),
                    onTap: () {
                      //_navigateTo(context, '');
                      Navigator.pop(context);
                    },
                    hoverColor: Colors.green.shade100.withOpacity(0.5),
                  ),
                  ListTile(
                    title: Text(
                      TextUtils.subscribedTitle,
                      style: const TextStyle(letterSpacing: 1),
                    ).tr(),
                    leading: const Icon(Icons.favorite_border_outlined),
                    onTap: () {
                      _navigateTo(context, 'subscribed');
                    },
                    hoverColor: Colors.green.shade100.withOpacity(0.5),
                  ),
                  ListTile(
                    title: Text(
                      TextUtils.adsFreeTitle,
                      style: const TextStyle(letterSpacing: 1),
                    ).tr(),
                    leading: const Icon(Icons.disabled_visible_outlined),
                    onTap: () {
                      _navigateTo(context, 'adsfree');
                    },
                    hoverColor: Colors.green.shade100.withOpacity(0.5),
                  ),
                  const Divider(),
                  ListTile(
                    title: Text(
                      TextUtils.settingsTitle,
                      style: const TextStyle(letterSpacing: 1),
                    ).tr(),
                    leading: const Icon(Icons.settings),
                    onTap: () {
                      _navigateTo(context, 'settings');
                    },
                    hoverColor: Colors.red.shade100.withOpacity(0.5),
                  ),
                  ListTile(
                    title: const Text(
                      "LOGOUT",
                      style: TextStyle(letterSpacing: 1),
                    ).tr(),
                    leading: Icon(
                      Icons.logout_sharp,
                      color: Colors.red.shade400,
                    ),
                    onTap: () => signOut(context),
                    hoverColor: Colors.green.shade100.withOpacity(0.5),
                  ),
                  // TextButton(
                  //     onPressed: () {
                  //       try {
                  //         exportFirestoreDataToCsv();
                  //       } catch (e) {
                  //         throw Exception("Failed to generate csv file: $e");
                  //       }
                  //     },
                  //     child: const Text("Generate CSV File")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    if (profileImage is File) {
      // Dosya yolu URI'ye dönüştürülüyor
      final fileUri = profileImage!.uri;
      // Dosya yolu geçerli mi diye kontrol ediliyor
      if (fileUri != null) {
        return Container(
          width: 48,
          height: 48,
          child: ClipOval(
            child: Image.file(profileImage!, fit: BoxFit.cover),
          ),
        );
      } else {
        // Dosya yolu geçersiz ise varsayılan ikon gösteriliyor
        return const Icon(Icons.account_circle, size: 48);
      }
    } else if (profileImage is String && profileImage.isNotEmpty) {
      return Container(
        width: 48,
        height: 48,
        child: ClipOval(
          child: Image.network(profileImage, fit: BoxFit.cover),
        ),
      );
    } else {
      // Varsayılan profil fotoğrafı
      return const Icon(Icons.account_circle, size: 48);
    }
  }

  void _navigateTo(BuildContext context, String route) {
    //Navigator.pop(context);
    if (ModalRoute.of(context)!.settings.name != route) {
      // Navigator.pushReplacementNamed(context, route);
      Navigator.popAndPushNamed(context, route);
    }
  }

  void signOut(BuildContext context) async {
    final _authService = AuthService();
    try {
      await _authService.signOut().then((value) => Navigator.pop(context));
    } catch (e) {
      AlertDialog(
        title: Text(e.toString()),
      );
    }
  }
}
