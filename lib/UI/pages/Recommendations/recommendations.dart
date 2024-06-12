import 'package:dio/dio.dart';
import 'package:final_year_project/DATA/State_Management/widget_providers/favorite_track_names_provider.dart';
import 'package:final_year_project/UI/pages/Recommendations/recommendation_play_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:like_button/like_button.dart';


class Recommendations extends ConsumerStatefulWidget {
  const Recommendations({super.key});

  @override
  ConsumerState createState() => _RecommendationsState();
}

final recommendationsProvider = FutureProvider<List<dynamic>>((ref) async {
  final favoriteTrackNames = ref.watch(favoriteTrackNamesProvider);
  List<String> songNames = favoriteTrackNames.toList();
  try {
    var response = await Dio().post(
      'http://10.0.2.2:8000/recommendations/',
      data: {"song_names": songNames},
    );
    if (response.statusCode == 200) {
      return response.data['recommendations'];
    } else {
      throw Exception("Failed to load recommendations");
    }
  } catch (e) {
    debugPrint("Error: $e");
    throw Exception("Failed to load recommendations");
  }
});

class _RecommendationsState extends ConsumerState<Recommendations> {
  // List<String> song = [];
  // List<dynamic> _recommendations = [];
  // Future<void> _getRecommendations() async {
  //   final favoriteTrackNames = ref.watch(favoriteTrackNamesProvider);
  //   List<String> songName = favoriteTrackNames.toList();
  //   try{
  //     var response = await Dio().post(
  //       'http://10.0.2.2:8000/recommendations/',
  //       data: {"song_names": songName},
  //     );
  //
  //     if(response.statusCode == 200) {
  //       setState(() {
  //         _recommendations = response.data['recommendations'];
  //       });
  //     }else {
  //       throw Exception("Failed to load recommendations");
  //     }
  //   }catch(e){
  //     debugPrint("Error: $e");
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    final recommendationsValue = ref.watch(recommendationsProvider);
    // return Scaffold(
    //   body: Column(
    //     children: [
    //       Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: ElevatedButton(
    //           onPressed: _getRecommendations,
    //           child: const Text('Get Recommendations'),
    //         ),
    //       ),
    //       Expanded(
    //         child: ListView.builder(
    //           itemCount: _recommendations.length,
    //           itemBuilder: (context, index) {
    //             return ListTile(
    //               title: Text(_recommendations[index]['name']),
    //               subtitle: Text(_recommendations[index]['artists']),
    //             );
    //           },
    //         ),
    //       ),
    //     ],
    //   ),
    // );
    return recommendationsValue.when(
      data: (recommendations) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final name = recommendations[index]['name'];
            final artists = recommendations[index]['artists'];
            final favs = ref.watch(favoriteTrackNamesProvider);
            List<String> favoritas = favs.toList();
            bool isFavorite = favoritas.contains(name) ? true : false;
            return ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PlayRecommendations(name, artists, isFavorite),
                    ));
              },
              leading: _buildTrackCoverImage(),
              title: Text(
                name,
              ),
              subtitle: Text(artists.toString()),
              trailing: _buildLikeButton(name),
              isThreeLine: true,
            );
          },
          itemCount: recommendations.length,
        );
      },
      error: (error, stackTrace) {
        return Center(
          child: Text("Failed to load recommendations: $error"),
        );
      },
      loading: () {
        return const SpinKitDancingSquare(
          color: Colors.deepPurpleAccent,
          size: 100,
        );
      },
    );
  }

  _buildTrackCoverImage() {
    return Image.asset('images/coverimage.jpeg');
  }

  _buildLikeButton(String trackName) {
    final favoriteTracks = ref.watch(favoriteTrackNamesProvider);
    final List<String> favorites = favoriteTracks.toList();
    late bool isFavorite;
    if (favorites.contains(trackName)) {
      isFavorite = true;
    } else {
      isFavorite = false;
    }
    return SizedBox(
      height: 50,
      width: 50,
      child: LikeButton(
        isLiked: isFavorite,
        size: 28,
        circleColor:
            const CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
        bubblesColor: const BubblesColor(
          dotPrimaryColor: Color(0xff33b5e5),
          dotSecondaryColor: Color(0xff0099cc),
        ),
        onTap: (isLiked) async {
          ref
              .read(favoriteTrackNamesProvider.notifier)
              .toggleFavoriteTrackNames(trackName);
          return !isLiked;
        },
      ),
    );
  }
}
