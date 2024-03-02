import 'dart:io';

import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final dynamic imageUrl;
  final void Function()? onTap;

  const UserTile({super.key, required this.text, this.onTap, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            _displayProfileImage(imageUrl),
            const SizedBox(width: 20),
            Text(
              text,
              style: const TextStyle(color: Colors.blueGrey,fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }

  _displayProfileImage(imageUrl) {
    if (imageUrl is File) {
      return CircleAvatar(
        radius: 32,
        backgroundImage: FileImage(imageUrl),
      );
    } else if (imageUrl is String && imageUrl.isNotEmpty) {
      return CircleAvatar(
        radius: 32,
        backgroundImage: NetworkImage(imageUrl),
      );
    } else {
      return const CircleAvatar(
        radius: 32,
        backgroundImage: AssetImage('images/profile_avatar.png'),
      );
    }
  }
}
