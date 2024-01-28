import 'package:easy_localization/easy_localization.dart';
import 'package:final_year_project/DATA/Auth/auth_service.dart';
import 'package:final_year_project/DATA/State_Management/widget_providers/user_provider.dart';
import 'package:final_year_project/UI/utils/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigationDrawerWidget extends ConsumerWidget {
  const NavigationDrawerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

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
                      leading: const CircleAvatar(
                        foregroundImage: NetworkImage(
                            'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/e7236087-24e0-41dc-9886-0cc0e6352edb/dffep1w-196d5430-cb72-40af-9d06-9aa0691551af.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcL2U3MjM2MDg3LTI0ZTAtNDFkYy05ODg2LTBjYzBlNjM1MmVkYlwvZGZmZXAxdy0xOTZkNTQzMC1jYjcyLTQwYWYtOWQwNi05YWEwNjkxNTUxYWYuanBnIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.utF89BRgsoiA57vT33kdZknxKF21HayN7RZtyKcVzlE'),
                        radius: 26,
                      ),
                      title: Text(user.name),
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
                  // ListTile(
                  //   title: Text('Chat'),
                  //   leading: const Icon(Icons.message_outlined),
                  //   onTap: () {
                  //     _navigateTo(context, 'chatting');
                  //   },
                  //   hoverColor: Colors.green.shade100.withOpacity(0.5),
                  // ),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
