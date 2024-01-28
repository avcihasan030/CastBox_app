import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportDialog extends StatefulWidget {
  const ReportDialog({super.key});

  @override
  _ReportDialogState createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  final TextEditingController _reportController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Hata Bildirim Formu"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _reportController,
            maxLines: 4,
            decoration: const InputDecoration(
              hintText: 'Lütfen şikayetinizi buraya yazın...',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(); // Dialog'u kapat
          },
          child: const Text('İptal'),
        ),
        ElevatedButton(
          onPressed: () {
            _sendReport(); // Şikayeti gönder
            Navigator.of(context).pop(); // Dialog'u kapat
          },
          child: const Text('Gönder'),
        ),
      ],
    );
  }

  void _sendReport() {
    String reportText = _reportController.text;

    // Burada raporu e-posta ile gönderme işlemini gerçekleştirebilirsiniz.
    _launchEmail(reportText);
  }

  Future<void> _launchEmail(String reportText) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'aavcihasan2001@gmail.com', // Geliştiricinin e-posta adresini buraya ekleyin
      queryParameters: {'subject': 'Uygulama Şikayeti', 'body': reportText},
    );

    try {
      await launch(emailLaunchUri.toString());
    } catch (e) {
      throw Exception("$e");
    }
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Uygulama'),
          actions: [
            IconButton(
              icon: const Icon(Icons.report),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const ReportDialog();
                  },
                );
              },
            ),
          ],
        ),
        body: const Center(
          child: Text('Ana Ekran'),
        ),
      ),
    );
  }
}
