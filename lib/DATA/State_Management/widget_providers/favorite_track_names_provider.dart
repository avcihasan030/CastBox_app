import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteTrackNamesProvider =
    StateNotifierProvider<FavoriteTrackNamesNotifier, Set<String>>((ref) {
  return FavoriteTrackNamesNotifier();
});

class FavoriteTrackNamesNotifier extends StateNotifier<Set<String>> {
  FavoriteTrackNamesNotifier() : super(<String>{});

  void toggleFavoriteTrackNames(String playlistName) {
    if (state.contains(playlistName)) {
      removePlaylistName(playlistName);
    } else {
      addPlaylistName(playlistName);
    }
  }

  void addPlaylistName(String playlistName) {
    state = Set.from(state)..add(playlistName);
  }

  void removePlaylistName(String playlistName) {
    state = Set.from(state)..remove(playlistName);
  }
}
