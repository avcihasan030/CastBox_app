

import 'package:dio/dio.dart';
import 'package:final_year_project/DATA/Models/api_models/artist_model.dart';
import 'package:final_year_project/DATA/Models/api_models/category_model.dart';
import 'package:final_year_project/DATA/Models/api_models/playlist_model.dart';

class SpotifyApiService {
  final String token;
  final Dio _dio = Dio();

  SpotifyApiService({required this.token});

  ///  api service code that fetches featured playlists
  Future<List<PlaylistItem>> getFeaturedPlaylists() async {
    try {
      final response = await _dio.get(
        'https://api.spotify.com/v1/browse/featured-playlists',
        queryParameters: {'country': 'US', 'limit': '24', 'offset': '0'},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );

      final List<PlaylistItem> playlists =
          (response.data['playlists']['items'] as List<dynamic>)
              .map((item) => PlaylistItem.fromJson(item))
              .toList();
      return playlists;
    } catch (error) {
      throw Exception("Failed to fetch featured playlists: $error");
    }
  }

  /// api service code that fetches category data
  Future<List<Category>> getCategories() async {
    try {
      final response = await _dio.get(
        'https://api.spotify.com/v1/browse/categories',
        queryParameters: {
          'country': 'US',
          'locale': 'en_US',
          'limit': '30',
          'offset': '0'
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );

      final categoriesJson =
          response.data['categories']['items'] as List<dynamic>;
      final List<Category> categories =
          categoriesJson.map((e) => Category.fromJson(e)).toList();
      return categories;
    } catch (error) {
      throw Exception("Failed to fetch categories: $error");
    }
  }

  /// api service code that fetches category playlists data
  Future<List<PlaylistItem>> getCategoryPlaylists(String categoryId) async {
    try {
      final response = await _dio.get(
        'https://api.spotify.com/v1/browse/categories/$categoryId/playlists',
        queryParameters: {'country': 'US', 'offset': '0'},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );

      final List<dynamic> playlistsJson =
          response.data['playlists']['items'] as List<dynamic>;

      /// filtering non-null values
      final List<PlaylistItem> playlists = playlistsJson
          .where((playlistJson) => playlistJson != null)
          .map((playlistJson) => PlaylistItem.fromJson(playlistJson))
          .toList();

      return playlists;
    } catch (error) {
      throw Exception("Failed to fetch category playlists: $error");
    }
  }

  /// api service code that fetches list of artists data
  Future<List<SpotifyArtist>> getArtists(List<String> artistIds) async {
    try {
      final response = await _dio.get(
        'https://api.spotify.com/v1/artists',
        queryParameters: {
          'ids': artistIds.join(','),
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );

      final List<dynamic> artistsJson =
          response.data['artists'] as List<dynamic>;
      final List<SpotifyArtist> artists =
          artistsJson.map((e) => SpotifyArtist.fromJson(e)).toList();

      return artists;
    } catch (error) {
      throw Exception("Failed to fetch artists: $error");
    }
  }
}
