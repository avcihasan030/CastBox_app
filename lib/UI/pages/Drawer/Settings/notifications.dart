import 'package:another_flushbar/flushbar.dart';
import 'package:final_year_project/DATA/Notification/notification_service.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  bool notificationsEnabled = true;
  //String bodyMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bildirim Ayarları'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: const Text('Bildirimleri Aç/Kapat'),
              trailing: Switch(
                value: notificationsEnabled,
                onChanged: (value) {
                  setState(() {
                    notificationsEnabled = value;
                    //bodyMessage = notificationsEnabled ? 'Artık Bildirim Alacaksınız':'Artık Bildirim Almayacaksınız';
                    _showNotificationMessage(value);
                    // NotificationService.showNotification(title: 'Notification', body: bodyMessage, payload: 'Bu bir payload');
                  });
                },
              ),
            ),
            const SizedBox(height: 16),
            // Text(
            //   notificationsEnabled
            //       ? 'Artık bildirim alacaksınız.'
            //       : 'Artık bildirim almayacaksınız.',
            //   style: TextStyle(
            //     fontSize: 16,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  void _showNotificationMessage(bool isEnabled) {
    String message = isEnabled
        ? 'Artık bildirim alacaksınız.'
        : 'Artık bildirim almayacaksınız.';

    Flushbar(
      message: message,
      duration: const Duration(seconds: 3),
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: const EdgeInsets.all(8),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    ).show(context);
  }
}
