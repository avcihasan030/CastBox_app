

import 'package:easy_localization/easy_localization.dart';
import 'package:final_year_project/UI/pages/Drawer/drawer_widgets/navigation_drawer.dart';
import 'package:final_year_project/UI/utils/text_utils.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TextUtils.historyTitle).tr(),
      ),
      drawer: const NavigationDrawerWidget(),
    );
  }
}
