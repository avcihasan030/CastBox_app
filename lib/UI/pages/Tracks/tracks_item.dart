import 'package:final_year_project/DATA/Models/database_models/database_tracks.dart';
import 'package:final_year_project/DATA/State_Management/widget_providers/favorite_track_names_provider.dart';
import 'package:final_year_project/DATA/State_Management/widget_providers/favorites_provider.dart';
import 'package:final_year_project/UI/pages/Tracks/track_play_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:like_button/like_button.dart';

class TracksItem extends ConsumerStatefulWidget {
  final Tracks tracks;
  final bool isFavorite;

  const TracksItem(this.tracks, this.isFavorite, {super.key});

  @override
  ConsumerState createState() => _TracksItemState();
}

class _TracksItemState extends ConsumerState<TracksItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  PlayTrackPage(widget.tracks, widget.isFavorite),
            ));
      },
      leading: buildTrackCoverImage(),
      title: buildTitlePadding(),
      subtitle: buildSubtitlePadding(),
      trailing: _buildLikeButton(widget.isFavorite),
      isThreeLine: true,
    );
  }

  Padding buildSubtitlePadding() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 8),
      child: Text(
        widget.tracks.artists!,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Padding buildTitlePadding() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 8),
      child: Text(
        widget.tracks.name,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  _buildLikeButton(bool isFavorite) {
    return SizedBox(
      height: 50,
      width: 50,
      child: LikeButton(
        isLiked: widget.isFavorite,
        size: 28,
        circleColor:
            const CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
        bubblesColor: const BubblesColor(
          dotPrimaryColor: Color(0xff33b5e5),
          dotSecondaryColor: Color(0xff0099cc),
        ),
        onTap: (isLiked) async {
          ref
              .read(favoritesProvider.notifier)
              .toggleFavorites(widget.tracks.id);
          ref
              .read(favoriteTrackNamesProvider.notifier)
              .toggleFavoriteTrackNames(widget.tracks.name);
          return !isLiked;
        },
      ),
    );
  }

  buildTrackCoverImage() {
    return Image.asset('images/coverimage.jpeg');
  }
}
