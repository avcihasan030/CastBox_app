
import 'package:final_year_project/DATA/Models/api_models/category_model.dart';
import 'package:final_year_project/DATA/State_Management/api_providers/spotify_api_provider.dart';
import 'package:final_year_project/DATA/State_Management/widget_providers/favorites_provider.dart';
import 'package:final_year_project/UI/pages/Playlists/playlist_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryPlaylistsPage extends ConsumerStatefulWidget {
  final Category category;
  const CategoryPlaylistsPage(this.category, {super.key});

  @override
  ConsumerState createState() => _CategoryPlaylistsPageState();
}

class _CategoryPlaylistsPageState extends ConsumerState<CategoryPlaylistsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    final playlistResult =
        ref.watch(categoryPlaylistsProvider(widget.category.id));
    final favorite = ref.read(favoritesProvider);
    debugPrint(widget.category.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
      ),
      body: playlistResult.when(
        data: (playlists) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final playlist = playlists[index];
              final playlistImage = playlist.images.isNotEmpty
                  ? playlist.images.first.url
                  : 'https://i.scdn.co/image/ab6765630000ba8ad75a9ab841cf1ed2933d26af';
              final isFavorite = favorite.contains(playlist.id);
              return ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PlaylistDetailsPage(
                      playlistItem: playlist,
                      isFavorite: isFavorite,
                    ),
                  ));
                },
                title: Text(playlist.name),
                subtitle: Text(playlist.description),
                leading: Image.network(
                  playlistImage,
                  fit: BoxFit.contain,
                ),
              );
            },
            itemCount: playlists.length,
          );
        },
        error: (error, stackTrace) {
          return Center(
            child: Text("Failed to load playlists: $error"),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
