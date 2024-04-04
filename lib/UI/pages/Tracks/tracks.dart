import 'package:final_year_project/DATA/State_Management/database_providers/database_providers.dart';
import 'package:final_year_project/DATA/State_Management/widget_providers/favorites_provider.dart';
import 'package:final_year_project/UI/pages/Tracks/tracks_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TracksPage extends ConsumerWidget {
  const TracksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tracksResult = ref.watch(dbTracksProvider);
    final favorite = ref.read(favoritesProvider);
    return tracksResult.when(
      data: (tracksList) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final track = tracksList[index];
            final isFavorite = favorite.contains(track.id);
            return TracksItem(track, isFavorite);
          },
          itemCount: tracksList.length,
        );
      },
      error: (error, stackTrace) {
        return Center(
          child: Text("Failed to load tracks from database: $error"),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
