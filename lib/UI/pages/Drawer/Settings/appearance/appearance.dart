import 'package:final_year_project/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Appearance extends ConsumerStatefulWidget {
  const Appearance({super.key});

  @override
  ConsumerState createState() => _AppearanceState();
}

class _AppearanceState extends ConsumerState<Appearance> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appearance'),
      ),
      // body: ListView(
      //   children: [
      //     RadioListTile(
      //       title: const Text('Dark Mode'),
      //       value: true,
      //       groupValue: isDarkTheme,
      //       onChanged: (value) {
      //         if (value != null && value != isDarkTheme) {
      //           ref.read(themeProvider.notifier).state = true;
      //         }
      //       },
      //     ),
      //     RadioListTile(
      //       title: const Text('Light Mode'),
      //       value: false,
      //       groupValue: isDarkTheme,
      //       onChanged: (value) {
      //         if (value != null && value != isDarkTheme) {
      //           ref.read(themeProvider.notifier).state = false;
      //         }
      //       },
      //     ),
      //   ],
      // ),
      body: ListTile(
        leading: IconButton(
            icon: Icon(MyApp.themeNotifier.value == ThemeMode.light
                ? Icons.dark_mode
                : Icons.light_mode),
            onPressed: () {
              MyApp.themeNotifier.value =
                  MyApp.themeNotifier.value == ThemeMode.light
                      ? ThemeMode.dark
                      : ThemeMode.light;
            }),
        title: const Text("Dark Mode"),
      ),
    );
  }
}
