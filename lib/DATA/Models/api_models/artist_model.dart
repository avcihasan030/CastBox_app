class SpotifyArtist {
  final String externalUrl;
  final Followers followers;
  final List<String> genres;
  final String? href;
  final String id;
  final List<ArtistImage> images;
  final String name;
  final int popularity;
  final String type;
  final String uri;

  SpotifyArtist({
    required this.externalUrl,
    required this.followers,
    required this.genres,
    required this.href,
    required this.id,
    required this.images,
    required this.name,
    required this.popularity,
    required this.type,
    required this.uri,
  });

  factory SpotifyArtist.fromJson(Map<String, dynamic> json) {
    return SpotifyArtist(
      externalUrl: json['external_urls']['spotify'],
      followers: Followers.fromJson(json['followers']),
      genres: List<String>.from(json['genres']),
      href: json['href'],
      id: json['id'],
      images: List<ArtistImage>.from(
          json['images'].map((image) => ArtistImage.fromJson(image))),
      name: json['name'],
      popularity: json['popularity'],
      type: json['type'],
      uri: json['uri'],
    );
  }
}

class Followers {
  final String? href;
  final int total;

  Followers({required this.href, required this.total});

  factory Followers.fromJson(Map<String, dynamic> json) {
    return Followers(
      href: json['href'],
      total: json['total'],
    );
  }
}

class ArtistImage {
  final String url;
  final int? height;
  final int? width;

  ArtistImage({required this.url, required this.height, required this.width});

  factory ArtistImage.fromJson(Map<String, dynamic> json) {
    return ArtistImage(
      url: json['url'],
      height: json['height'],
      width: json['width'],
    );
  }
}
