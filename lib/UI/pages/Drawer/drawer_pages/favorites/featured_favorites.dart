import 'package:final_year_project/DATA/State_Management/database_providers/database_providers.dart';
import 'package:final_year_project/DATA/State_Management/widget_providers/favorites_provider.dart';
import 'package:final_year_project/UI/pages/Tracks/track_play_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FeaturedFavorites extends ConsumerWidget {
  const FeaturedFavorites({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);
    final playlists = ref.watch(dbTracksProvider);

    return Scaffold(
      body: favorites.isEmpty
          ? const Center(
              child: Text("You have no favorite playlists."),
            )
          : playlists.when(
              data: (data) {
                final favoritePlaylists = data
                    .where((element) => favorites.contains(element.id))
                    .toList();
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 1.0,
                      mainAxisSpacing: 1.0),
                  itemBuilder: (context, index) {
                    final playlist = favoritePlaylists[index];
                    return GridTile(
                      child: Card(
                        elevation: 0,
                        child: GestureDetector(
                          child: Column(
                            children: [
                              SizedBox(
                                child: Image.asset(
                                  'images/coverimage.jpeg',
                                  fit: BoxFit.fill,
                                  width: 150,
                                  height: 120,
                                ),
                              ),
                              Container(
                                color: Colors.black87,
                                width: 150,
                                height: 70,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          playlist.name,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        //playlist.owner.displayName,
                                        playlist.artists!,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 11),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            final favs = ref.watch(favoritesProvider);
                            bool isFavorite;
                            if (favs.contains(playlist.id)) {
                              isFavorite = true;
                            } else {
                              isFavorite = false;
                            }
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PlayTrackPage(playlist, isFavorite),
                                ));
                          },
                        ),
                      ),
                    );
                  },
                  itemCount: favorites.length,
                );
              },
              error: (error, stackTrace) {
                debugPrint("Error: $error");
                return Center(
                  child: Text("Error: $error"),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
    );
  }
}
