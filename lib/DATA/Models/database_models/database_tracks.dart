class Tracks {
  final String id;
  final String name;
  final String popularity;
  final String? artists;
  final String releaseDate;
  final bool isFavorite;

  Tracks(
      {required this.id,
      required this.name,
      required this.popularity,
      required this.artists,
      required this.releaseDate,
      this.isFavorite = false});
}
