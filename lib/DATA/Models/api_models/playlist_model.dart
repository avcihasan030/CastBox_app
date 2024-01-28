class SpotifyCategoryPlaylists {
  final Playlists playlists;

  SpotifyCategoryPlaylists({required this.playlists});

  factory SpotifyCategoryPlaylists.fromJson(Map<String, dynamic> json) {
    return SpotifyCategoryPlaylists(
      playlists: Playlists.fromJson(json['playlists']),
    );
  }
}

class Playlists {
  final String href;
  final int limit;
  final String? next;
  final int offset;
  final int total;
  final List<PlaylistItem> items;

  Playlists({
    required this.href,
    required this.limit,
    required this.next,
    required this.offset,
    required this.total,
    required this.items,
  });

  factory Playlists.fromJson(Map<String, dynamic> json) {
    var playlistItems = <PlaylistItem>[];
    if (json['items'] != null) {
      json['items'].forEach((v) {
        playlistItems.add(PlaylistItem.fromJson(v));
      });
    }

    return Playlists(
      href: json['href'],
      limit: json['limit'],
      next: json['next'],
      offset: json['offset'],
      total: json['total'],
      items: playlistItems,
    );
  }
}

class PlaylistItem {
  final bool collaborative;
  final String description;
  final ExternalUrls externalUrls;
  final String href;
  final String id;
  final List<ImageItem> images;
  final String name;
  final Owner owner;
  final dynamic public;
  final String snapshotId;
  final Tracks tracks;
  final String type;
  final String uri;
  final dynamic primaryColor;
  bool isFavorite;

  PlaylistItem(
      {required this.collaborative,
        required this.description,
        required this.externalUrls,
        required this.href,
        required this.id,
        required this.images,
        required this.name,
        required this.owner,
        required this.public,
        required this.snapshotId,
        required this.tracks,
        required this.type,
        required this.uri,
        required this.primaryColor,
        this.isFavorite = false});

  factory PlaylistItem.fromJson(Map<String, dynamic> json) {
    var imageItems = <ImageItem>[];
    if (json['images'] != null) {
      json['images'].forEach((v) {
        imageItems.add(ImageItem.fromJson(v));
      });
    }

    return PlaylistItem(
      collaborative: json['collaborative'],
      description: json['description'],
      externalUrls: ExternalUrls.fromJson(json['external_urls']),
      href: json['href'],
      id: json['id'],
      images: imageItems,
      name: json['name'],
      owner: Owner.fromJson(json['owner']),
      public: json['public'],
      snapshotId: json['snapshot_id'],
      tracks: Tracks.fromJson(json['tracks']),
      type: json['type'],
      uri: json['uri'],
      primaryColor: json['primary_color'],
    );
  }
}

class ExternalUrls {
  final String spotify;

  ExternalUrls({required this.spotify});

  factory ExternalUrls.fromJson(Map<String, dynamic> json) {
    return ExternalUrls(
      spotify: json['spotify'],
    );
  }
}

class ImageItem {
  final String url;
  final dynamic height;
  final dynamic width;

  ImageItem({required this.url, required this.height, required this.width});

  factory ImageItem.fromJson(Map<String, dynamic> json) {
    return ImageItem(
      url: json['url'],
      height: json['height'],
      width: json['width'],
    );
  }
}

class Owner {
  final ExternalUrls externalUrls;
  final String href;
  final String id;
  final String type;
  final String uri;
  final String displayName;

  Owner({
    required this.externalUrls,
    required this.href,
    required this.id,
    required this.type,
    required this.uri,
    required this.displayName,
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      externalUrls: ExternalUrls.fromJson(json['external_urls']),
      href: json['href'],
      id: json['id'],
      type: json['type'],
      uri: json['uri'],
      displayName: json['display_name'],
    );
  }
}

class Tracks {
  final String href;
  final int total;

  Tracks({required this.href, required this.total});

  factory Tracks.fromJson(Map<String, dynamic> json) {
    return Tracks(
      href: json['href'],
      total: json['total'],
    );
  }
}
