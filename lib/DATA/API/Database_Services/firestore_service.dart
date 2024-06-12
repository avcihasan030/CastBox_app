import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/DATA/Models/database_models/database_tracks.dart';

class FirestoreService {
  final CollectionReference tracksCollection =
      FirebaseFirestore.instance.collection('tracks');

  Future<List<Tracks>> getTracks() async {
    try {
      final response = await tracksCollection.get();
      final List<Tracks> tracks = response.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        String artists = data['artists'] ?? '';
        return Tracks(
          id: data['id'] ?? '',
          name: data['name'] ?? '',
          popularity: data['popularity'] ?? '',
          artists: artists,
          releaseDate: data['releaseDate'] ?? '',
        );
      }).toList();
      return tracks;
    } catch (e) {
      throw Exception("Failed to fetch tracks: $e");
    }
  }
}