import 'package:easy_localization/easy_localization.dart';
import 'package:final_year_project/DATA/State_Management/widget_providers/tab_providers.dart';
import 'package:final_year_project/UI/pages/Drawer/drawer_widgets/navigation_drawer.dart';
import 'package:final_year_project/UI/pages/Home/icon_button.dart';
import 'package:final_year_project/UI/pages/Home/popup_menu.dart';
import 'package:final_year_project/UI/utils/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    context.locale;
    final selectedTabIndex = ref.watch(selectedTabIndexProvider.notifier).state;
    final pages = ref.watch(pagesProvider);
    ThemeData themeData = Theme.of(context);
    return DefaultTabController(
      initialIndex: selectedTabIndex,
      length: pages.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            TextUtils.getAppBarTitle(
              TextUtils.mainTitle,
            ),
            style: TextUtils.getAppBarTitleTextStyle(),
          ).tr(),
          bottom: TabBar(
            onTap: (index) {
              ref.read(selectedTabIndexProvider.notifier).state = index;
            },
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            tabs: [
              Tab(
                child: Text(TextUtils.featuredTabTitle,
                    style: TextUtils.getTabTitleTextStyle()).tr(),
              ),
              Tab(
                child: Text(TextUtils.trendingTabTitle,
                    style: TextUtils.getTabTitleTextStyle()).tr(),
              ),
              Tab(
                child: Text(TextUtils.categoryTabTitle,
                    style: TextUtils.getTabTitleTextStyle()).tr(),
              ),
              Tab(
                child: Text(TextUtils.networkTabTitle,
                    style: TextUtils.getTabTitleTextStyle()).tr(),
              ),
            ],
          ),
          actions: const [
            IconButtonWidget(),
            PopupMenuWidget(),
          ],
        ),
        body: SafeArea(
          child: TabBarView(
            children: pages,
          ),
        ),
        drawer: const NavigationDrawerWidget(),
      ),
    );
  }
}
