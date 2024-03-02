
import 'package:final_year_project/DATA/API/services/spotify_api_client.dart';
import 'package:final_year_project/DATA/API/services/spotify_api_services.dart';
import 'package:final_year_project/DATA/Models/api_models/artist_model.dart';
import 'package:final_year_project/DATA/Models/api_models/category_model.dart';
import 'package:final_year_project/DATA/Models/api_models/playlist_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// provider that gets access token from client
final accessTokenProvider = FutureProvider<String>((ref) async {
  final spotifyApiClient = SpotifyApiClient();
  final accessToken = await spotifyApiClient.getAccessToken();
  return accessToken;
});

/// provider that uses access token in service code
final spotifyApiServiceProvider = Provider((ref) {
  final accessToken = ref.read(accessTokenProvider);

  if (accessToken is AsyncData<String>) {
    return SpotifyApiService(token: accessToken.value);
  } else {
    throw Exception("Access token not available");
  }
});

/// provider to fetch the list of featured playlists data
final featuredPlaylistProvider =
    FutureProvider.autoDispose<List<PlaylistItem>>((ref) async {
  final service = ref.read(spotifyApiServiceProvider);
  final playlists = await service.getFeaturedPlaylists();
  return playlists;
});

final categoriesProvider =
    FutureProvider.autoDispose<List<Category>>((ref) async {
  final service = ref.read(spotifyApiServiceProvider);
  final categories = await service.getCategories();
  service.addCategoriesToFirestore();
  return categories;
});

final categoryPlaylistsProvider = FutureProvider.autoDispose
    .family<List<PlaylistItem>, String>((ref, categoryId) async {
  final service = ref.read(spotifyApiServiceProvider);
  final playlists = await service.getCategoryPlaylists(categoryId);
  service.addCategoryPlaylistsToFirestore(categoryId);
  return playlists;
});

final artistsProvider =
    FutureProvider.autoDispose<List<SpotifyArtist>>((ref) async {
  final service = ref.watch(spotifyApiServiceProvider);
  final artistIds = [
    '2CIMQHirSU0MQqyYHq0eOx',
    '57dN52uHvrHOxijzpIgu3E',
    '1vCWHaC5f2uS3yhpwWbIA6',
    '7fKO99ryLDo8VocdtVvwZW',
    '0hCNtLu0JehylgoiP8L4Gh',
    '0eDvMgVFoNV3TpwtrVCoTj',
    '1McMsnEElThX1knmY4oliG',
    '0TnOYISbd1XYRBk9myaseg',
    '0kbYTNQb4Pb1rPbbaF0pT4',
    '1Ziwj8Ygad7R55HjGOpN7W',
    '5XzDRWfcUpeL9VTGz7Nlud',
    '2dsG3u5vUZSGpQGEsq1unH',
    '3dRfiJ2650SZu6GbydcHNb',
    '0gY2lNJ6Lkkul3emjvqU9j',
    '4cMwyqmHCwJjRZ3frIVHTr',
    '35nUzvEFgf2TzqnRdIMYjg',
    '6bRTEieKlIK6JMuPCjXiro',
    '0gPgE6wLLiPnrakh9WcsdQ',
    '3Nrfpe0tUJi4K4DXYWgMUX',
    '6h971vhkhZ8eM5SQjHi0Ta',
    '1Oa0bMld0A3u5OTYfMzp5h',
    '1YfEcTuGvBQ8xSD1f53UnK',
    '0Y5tJX1MQlPlqiwlOH1tJY',
  ];
  final artists = service.getArtists(artistIds);
  return artists;
});
