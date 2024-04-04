
import 'package:easy_localization/easy_localization.dart';
import 'package:final_year_project/DATA/State_Management/widget_providers/favorites_provider.dart';
import 'package:final_year_project/UI/utils/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTabIndex =
        ref.watch(selectedFavoriteTabIndexProvider.notifier).state;
    final pages = ref.watch(favoritePagesProvider);
    return DefaultTabController(
      initialIndex: selectedTabIndex,
      length: pages.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(TextUtils.subscribedTitle).tr(),
          bottom: TabBar(
            onTap: (index) {
              ref.read(selectedFavoriteTabIndexProvider.notifier).state;
            },
            tabs: [
              Tab(
                child: Text(
                  "Liked Tracks",
                  style: TextUtils.getTabTitleTextStyle(),
                ),
              ),
              Tab(
                child: Text(
                  "For You",
                  style: TextUtils.getTabTitleTextStyle(),
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(child: TabBarView(children: pages)),
      ),
    );
  }
}
