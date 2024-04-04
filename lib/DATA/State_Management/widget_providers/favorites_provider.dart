
import 'package:final_year_project/UI/pages/Drawer/drawer_pages/favorites/featured_favorites.dart';
import 'package:final_year_project/UI/pages/Recommendations/recommendations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, Set<String>>((ref) {
  return FavoritesNotifier();
});

final selectedFavoriteTabIndexProvider = StateProvider<int>((ref) => 0);

final favoritesPageControllerProvider = Provider<PageController>((ref) {
  final selectedFavoriteTabIndex = ref.watch(selectedFavoriteTabIndexProvider);
  return PageController(initialPage: selectedFavoriteTabIndex);
});


final favoritePagesProvider = Provider<List<Widget>>((ref) {
  return [
    const FeaturedFavorites(),
    Recommendations(),
  ];
});

class FavoritesNotifier extends StateNotifier<Set<String>> {
  FavoritesNotifier() : super(<String>{});

  void toggleFavorites(String playlistId) {
    if (state.contains(playlistId)) {
      state = Set.from(state)..remove(playlistId);
    } else {
      state = Set.from(state)..add(playlistId);
    }
  }
}
