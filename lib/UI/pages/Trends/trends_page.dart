
import 'package:final_year_project/DATA/State_Management/api_providers/spotify_api_provider.dart';
import 'package:final_year_project/DATA/State_Management/widget_providers/favorites_provider.dart';
import 'package:final_year_project/UI/pages/Playlists/featured_playlist_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrendsPage extends ConsumerStatefulWidget {
  const TrendsPage({super.key});

  @override
  ConsumerState createState() => _TrendsPageState();
}

class _TrendsPageState
    extends ConsumerState<TrendsPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final playlistsResult = ref.watch(featuredPlaylistProvider);
    final favorite = ref.read(favoritesProvider);
    return playlistsResult.when(
      data: (playlists) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final playlist = playlists[index];
            final isFavorite = favorite.contains(playlist.id);
            return PlaylistItemTest(
              playlist: playlist,
              isFavorite: isFavorite,
              key: Key('playlist_item_$index'),
            );
          },
          itemCount: playlists.length,
        );
      },
      error: (error, stackTrace) =>
          Center(child: Text("Failed to load trending playlists: $error")),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
