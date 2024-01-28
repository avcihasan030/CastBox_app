// class FeaturedPlaylists {
//   final String message;
//   final PlaylistData playlists;
//
//   FeaturedPlaylists({
//     required this.message,
//     required this.playlists,
//   });
//
//   factory FeaturedPlaylists.fromJson(Map<String, dynamic> json) {
//     return FeaturedPlaylists(
//       message: json['message'] ?? '',
//       playlists: PlaylistData.fromJson(json['playlists'] ?? const {}),
//     );
//   }
// }
//
// class PlaylistData {
//   final String href;
//   final int limit;
//   final String? next;
//   final int offset;
//   final String? previous;
//   final int total;
//   final List<PlaylistItem> items;
//
//   PlaylistData({
//     required this.href,
//     required this.limit,
//     this.next,
//     required this.offset,
//     this.previous,
//     required this.total,
//     required this.items,
//   });
//
//   factory PlaylistData.fromJson(Map<String, dynamic> json) {
//     return PlaylistData(
//       href: json['href'] ?? '',
//       limit: json['limit'] ?? 0,
//       next: json['next'] ?? '',
//       offset: json['offset'] ?? 0,
//       previous: json['previous'] ?? '',
//       total: json['total'] ?? 0,
//       items: List<PlaylistItem>.from((json['items'] ?? [])
//           .map((item) => PlaylistItem.fromJson(item ?? const {}))),
//     );
//   }
// }
//
// class PlaylistItem {
//   final bool collaborative;
//   final String description;
//   final ExternalUrls externalUrls;
//   final String href;
//   final String id;
//   final List<PlaylistImage> images;
//   final String name;
//   final PlaylistOwner owner;
//   final bool? public;
//   final String snapshotId;
//   final PlaylistTracks tracks;
//   final String type;
//   final String uri;
//   final String? primaryColor;
//   bool isFavorite;
//
//   PlaylistItem(
//       {required this.collaborative,
//         required this.description,
//         required this.externalUrls,
//         required this.href,
//         required this.id,
//         required this.images,
//         required this.name,
//         required this.owner,
//         this.public,
//         required this.snapshotId,
//         required this.tracks,
//         required this.type,
//         required this.uri,
//         this.primaryColor,
//         this.isFavorite = false});
//
//   factory PlaylistItem.fromJson(Map<String, dynamic> json) {
//     return PlaylistItem(
//       collaborative: json['collaborative'] ?? false,
//       description: json['description'] ?? '',
//       externalUrls: ExternalUrls.fromJson(json['external_urls'] ?? const {}),
//       href: json['href'] ?? '',
//       id: json['id'] ?? '',
//       images: List<PlaylistImage>.from((json['images'] ?? [])
//           .map((item) => PlaylistImage.fromJson(item ?? const {}))),
//       name: json['name'] ?? '',
//       owner: PlaylistOwner.fromJson(json['owner'] ?? const {}),
//       public: json['public'],
//       snapshotId: json['snapshot_id'] ?? '',
//       tracks: PlaylistTracks.fromJson(json['tracks'] ?? const {}),
//       type: json['type'] ?? '',
//       uri: json['uri'] ?? '',
//       primaryColor: json['primary_color'],
//     );
//   }
// }
//
// class ExternalUrls {
//   final String spotify;
//
//   ExternalUrls({
//     required this.spotify,
//   });
//
//   factory ExternalUrls.fromJson(Map<String, dynamic> json) {
//     return ExternalUrls(
//       spotify: json['spotify'] ?? '',
//     );
//   }
// }
//
// class PlaylistImage {
//   final String url;
//
//   PlaylistImage({
//     required this.url,
//   });
//
//   factory PlaylistImage.fromJson(Map<String, dynamic> json) {
//     return PlaylistImage(
//       url: json['url'] ?? '',
//     );
//   }
// }
//
// class PlaylistOwner {
//   final ExternalUrls externalUrls;
//   final String href;
//   final String id;
//   final String type;
//   final String uri;
//   final String displayName;
//
//   PlaylistOwner({
//     required this.externalUrls,
//     required this.href,
//     required this.id,
//     required this.type,
//     required this.uri,
//     required this.displayName,
//   });
//
//   factory PlaylistOwner.fromJson(Map<String, dynamic> json) {
//     return PlaylistOwner(
//       externalUrls: ExternalUrls.fromJson(json['external_urls'] ?? const {}),
//       href: json['href'] ?? '',
//       id: json['id'] ?? '',
//       type: json['type'] ?? '',
//       uri: json['uri'] ?? '',
//       displayName: json['display_name'] ?? '',
//     );
//   }
// }
//
// class PlaylistTracks {
//   final String href;
//   final int total;
//
//   PlaylistTracks({
//     required this.href,
//     required this.total,
//   });
//
//   factory PlaylistTracks.fromJson(Map<String, dynamic> json) {
//     return PlaylistTracks(
//       href: json['href'] ?? '',
//       total: json['total'] ?? 0,
//     );
//   }
// }
