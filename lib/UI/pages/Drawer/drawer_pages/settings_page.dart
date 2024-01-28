
import 'package:easy_localization/easy_localization.dart';
import 'package:final_year_project/DATA/Models/settings_model.dart';
import 'package:final_year_project/DATA/State_Management/widget_providers/settings_provider.dart';
import 'package:final_year_project/UI/pages/Drawer/Settings/about.dart';
import 'package:final_year_project/UI/pages/Drawer/Settings/appearance/appearance.dart';
import 'package:final_year_project/UI/pages/Drawer/Settings/notifications.dart';
import 'package:final_year_project/UI/pages/Drawer/Settings/profile.dart';
import 'package:final_year_project/UI/pages/Drawer/Settings/purchases.dart';
import 'package:final_year_project/UI/pages/Drawer/Settings/reports.dart';
import 'package:final_year_project/UI/utils/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    return Scaffold(
      //drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text(TextUtils.settingsTitle).tr(),
        elevation: 2,
      ),
      //drawer: const NavigationDrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: ListView.builder(
          itemBuilder: (context, index) {
            final setting = settings[index];
            return ListTile(
              leading: Icon(setting.settingIcon),
              title: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(setting.type).tr(),
              ),
              onTap: () {
                _handleSettingTap(context, setting);
              },
            );
          },
          itemCount: settings.length,
        ),
      ),
    );
  }

  void _handleSettingTap(BuildContext context, Settings setting) {
    switch (setting.type) {
      case 'Profile':
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProfilePage(),
          ),
        );
        break;
      case 'Appearance':
        // Dil ayarları sayfasını açmak için yönlendirme yapabilirsiniz.
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Appearance(),
          ),
        );
        break;
      case 'Notification':
        // Dil ayarları sayfasını açmak için yönlendirme yapabilirsiniz.
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const Notifications(),
          ),
        );
        break;
      case 'Purchases':
        // Dil ayarları sayfasını açmak için yönlendirme yapabilirsiniz.
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Purchases(),
          ),
        );
        break;
      case 'Reports':
        // Dil ayarları sayfasını açmak için yönlendirme yapabilirsiniz.
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ReportDialog(),
          ),
        );
        break;
      case 'About':
        // Dil ayarları sayfasını açmak için yönlendirme yapabilirsiniz.
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const About(),
          ),
        );
        break;
    }
  }
}
