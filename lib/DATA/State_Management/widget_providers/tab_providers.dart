
import 'package:final_year_project/UI/pages/Artists/artists_page.dart';
import 'package:final_year_project/UI/pages/Categories/categories_page.dart';
import 'package:final_year_project/UI/pages/Featured/featured_page.dart';
import 'package:final_year_project/UI/pages/Trends/trends_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedTabIndexProvider = StateProvider<int>(
      (ref) => 0,
);

final pageControllerProvider = Provider<PageController>((ref) {
  final selectedTabIndex = ref.watch(selectedTabIndexProvider.notifier).state;
  return PageController(initialPage: selectedTabIndex);
});

final pagesProvider = Provider<List<Widget>>((ref) {
  return [
    const FeaturedPage(),
    const TrendsPage(),
    const CategoriesPage(),
    const ArtistsPage(),
  ];
});
