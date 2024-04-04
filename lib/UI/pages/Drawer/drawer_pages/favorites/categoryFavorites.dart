//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:final_year_project/DATA/State_Management/api_providers/spotify_api_provider.dart';
// import 'package:final_year_project/DATA/State_Management/widget_providers/favorites_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// class CategoryFavorites extends ConsumerWidget {
//   const CategoryFavorites({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final favorites = ref.watch(favoritesProvider);
//     final playlists = ref.watch(featuredPlaylistProvider);
//
//     return Scaffold(
//       body: favorites.isEmpty
//           ? const Center(
//               child: Text("You have no favorite playlists."),
//             )
//           : playlists.when(
//               data: (data) {
//                 final favoritePlaylists = data
//                     .where((element) => favorites.contains(element.id))
//                     .toList();
//                 return GridView.builder(
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       crossAxisSpacing: 1.0,
//                       mainAxisSpacing: 1.0),
//                   itemBuilder: (context, index) {
//                     final playlist = favoritePlaylists[index];
//                     return GridTile(
//                       child: Card(
//                         elevation: 0,
//                         child: GestureDetector(
//                           child: Column(
//                             children: [
//                               SizedBox(
//                                 child: CachedNetworkImage(
//                                   imageUrl: playlist.images.first.url,
//                                   fit: BoxFit.fill,
//                                   width: 150,
//                                   height: 120,
//                                 ),
//                               ),
//                               Container(
//                                 color: Colors.black87,
//                                 width: 150,
//                                 height: 70,
//                                 child: Column(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Expanded(
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Text(
//                                           playlist.name,
//                                           overflow: TextOverflow.ellipsis,
//                                           style: const TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 14),
//                                         ),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Text(
//                                         playlist.owner.displayName,
//                                         overflow: TextOverflow.ellipsis,
//                                         style: const TextStyle(
//                                             color: Colors.grey, fontSize: 11),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                           onTap: () {
//                             debugPrint("${playlist.description} clicked!");
//                           },
//                         ),
//                       ),
//                     );
//                   },
//                   itemCount: favorites.length,
//                 );
//               },
//               error: (error, stackTrace) {
//                 debugPrint("Error: $error");
//                 return Center(
//                   child: Text("Error: $error"),
//                 );
//               },
//               loading: () => const Center(child: CircularProgressIndicator()),
//             ),
//     );
//   }
// }
