import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  const About({super.key});

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'URL başlatılamadı: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('About Us'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
              'Merhaba, bu uygulama şirketimiz tarafından geliştirilmiştir.'),
          const SizedBox(height: 8),
          const Text('Geliştirici: Hasan Avcı'),
          const SizedBox(height: 8),
          const Text('Email: aavcihasan2001@gmail.com'),
          const SizedBox(height: 16),
          const Text('Sosyal Medya Hesapları:'),
          ListTile(
            leading: const Icon(
              Ionicons.logo_linkedin,
              color: Colors.blue,
            ),
            title: const Text('LinkedIn'),
            onTap: () {
              _launchURL('https://www.linkedin.com/in/hasan-avci-230a41215/');
            },
          ),
          ListTile(
            leading: const Icon(Ionicons.logo_github),
            title: const Text('GitHub'),
            onTap: () {
              _launchURL('https://github.com/avcihasan030');
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Kapat'),
        ),
      ],
    );
  }
}
