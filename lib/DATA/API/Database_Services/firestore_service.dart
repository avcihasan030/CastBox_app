import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/DATA/Models/database_models/database_playlist.dart';
import '../../Models/database_models/database_category.dart';

class FirestoreService {
  final CollectionReference categoriesCollection =
      FirebaseFirestore.instance.collection('categories');
  final CollectionReference playlistCollection =
      FirebaseFirestore.instance.collection('playlists');

  // Future<void> addCategory(String id, String name) async {
  //   try {
  //     await categoriesCollection.doc(id).set({'id': id, 'name': name});
  //   } catch (e) {
  //     throw Exception("Failed to add category: $e");
  //   }
  // }
  //
  // Future<void> addPlaylistToCategory(String categoryId, String playlistId,
  //     String name, String description) async {
  //   try {
  //     await playlistCollection.doc(playlistId).set(
  //         {'id':playlistId,'categoryId': categoryId, 'name': name, 'description': description});
  //   } catch (e) {
  //     throw Exception("Failed to add playlist to category: $e");
  //   }
  // }

  Future<List<Category>> getCategories() async {
    try {
      final response = await categoriesCollection.get();
      final List<Category> categories = response.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Category(id: data['id'], name: data['name']);
      }).toList();
      return categories;
    } catch (e) {
      throw Exception("Failed to fetch categories: $e");
    }
  }

  Future<List<Playlist>> getCategoryPlaylists(String categoryId) async {
    try {
      final response = await playlistCollection
          .where('categoryId', isEqualTo: categoryId)
          .get();
      final List<Playlist> playlists = response.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Playlist(
            id: data['id'],
            name: data['name'],
            description: data['description']);
      }).toList();
      return playlists;
    } catch (e) {
      throw Exception("Failed to fetch category playlists: $e");
    }
  }
}
