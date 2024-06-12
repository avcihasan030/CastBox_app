import 'package:final_year_project/DATA/API/Database_Services/firestore_service.dart';
import 'package:final_year_project/DATA/Models/database_models/database_tracks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firestoreServiceProvider = Provider<FirestoreService>((ref) {
  return FirestoreService();
});

final dbTracksProvider = FutureProvider<List<Tracks>>((ref) async {
  final firestoreService = ref.read(firestoreServiceProvider);
  return await firestoreService.getTracks();
});
