
import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_year_project/DATA/Models/api_models/category_model.dart';
import 'package:final_year_project/DATA/State_Management/api_providers/spotify_api_provider.dart';
import 'package:final_year_project/DATA/State_Management/widget_providers/favorites_provider.dart';
import 'package:final_year_project/UI/pages/Categories/category_playlists_page.dart';
import 'package:final_year_project/UI/pages/Playlists/playlist_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaylistCard extends ConsumerStatefulWidget {
  final Category category;
  const PlaylistCard(this.category, {super.key});

  @override
  ConsumerState createState() => _FeaturedCardState();
}

class _FeaturedCardState extends ConsumerState<PlaylistCard> {
  @override
  Widget build(BuildContext context) {
    final playlists = ref.watch(categoryPlaylistsProvider(widget.category.id));
    final favorite = ref.read(favoritesProvider);
    return playlists.when(
      data: (data) {
        final categoryPlaylists = data.take(3).toList();
        return Card(
          shape: const ContinuousRectangleBorder(),
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 8, top: 8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.category.name,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  CategoryPlaylistsPage(widget.category),
                            ));
                          },
                          child: const Text(
                            "See All",
                            style: TextStyle(fontSize: 16),
                          )),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 1, left: 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    for (final playlist in categoryPlaylists)
                      Expanded(
                        child: Card(
                          elevation: 2,
                          child: GestureDetector(
                            child: Column(
                              children: [
                                SizedBox(
                                  child: /*Image.network(
                                    playlist.images.first.url,
                                    fit: BoxFit.fill,
                                    width: 150,
                                    height: 120,
                                  ),*/
                                  CachedNetworkImage(
                                    imageUrl: playlist.images.first.url,
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
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
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
                                          playlist.owner.displayName,
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
                              final isFavorite = favorite.contains(playlist.id);
                              debugPrint(
                                  "${playlist.description} clicked!\n category: ${widget.category.name}");
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PlaylistDetailsPage(
                                  playlistItem: playlist,
                                  isFavorite: isFavorite,
                                ),
                              ));
                            },
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      error: (error, stackTrace) {
        debugPrint("Error: $error");
        return Center(
          child: Text("Error: $error"),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

