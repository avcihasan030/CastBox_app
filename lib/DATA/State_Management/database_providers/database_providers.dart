import 'package:final_year_project/DATA/API/Database_Services/firestore_service.dart';
import 'package:final_year_project/DATA/Models/database_models/database_tracks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final firestoreServiceProvider = Provider<FirestoreService>((ref) {
//   return FirestoreService();
// });
//
// final dbCategoriesProvider = FutureProvider<List<Category>>((ref) async {
//   final firestoreService = ref.read(firestoreServiceProvider);
//   return await firestoreService.getCategories();
// });
//
// final dbCategoryPlaylistsProvider =
//     FutureProvider.family<List<Playlist>, String>((ref, categoryId) async {
//   final firestoreService = ref.read(firestoreServiceProvider);
//   return await firestoreService.getCategoryPlaylists(categoryId);
// });

final firestoreServiceProvider = Provider<FirestoreService>((ref) {
  return FirestoreService();
});

final dbTracksProvider = FutureProvider.autoDispose<List<Tracks>>((ref) async {
  final firestoreService = ref.read(firestoreServiceProvider);
  return await firestoreService.getTracks();
});
