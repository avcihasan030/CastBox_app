import 'package:easy_localization/easy_localization.dart';
import 'package:final_year_project/UI/Chat_UI/user_list_page.dart';
import 'package:final_year_project/UI/pages/Drawer/drawer_pages/ads_free_page.dart';
import 'package:final_year_project/UI/pages/Drawer/drawer_pages/favorites/favorites_page.dart';
import 'package:final_year_project/UI/pages/Drawer/drawer_pages/settings_page.dart';
import 'package:final_year_project/UI/pages/Home/home_page.dart';
import 'package:final_year_project/UI/pages/Splash/splash_screen.dart';
import 'package:final_year_project/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('tr', 'TR'),
        Locale('es', 'ES')
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: const ProviderScope(child: MyApp()),
    ),
  );
}

class MyApp extends ConsumerWidget {
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: currentMode,
          debugShowCheckedModeBanner: false,
          title: 'CASTBOX',
          //home: const SplashScreen(),
          initialRoute: 'splash',
          routes: {
            'splash':(context) => const SplashScreen(),
            '': (context) => const HomePage(),
            'subscribed': (context) => const FavoritesPage(),
            //'history': (context) => const HistoryPage(),
            'adsfree': (context) => const AdsFreePage(),
            'settings': (context) => const SettingsPage(),
            'chatting': (context) => DisplayUsersPage(),
          },
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
        );
      },
    );
  }
}
