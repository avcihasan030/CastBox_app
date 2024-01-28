
import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_year_project/DATA/Models/api_models/playlist_model.dart';
import 'package:final_year_project/DATA/State_Management/widget_providers/favorites_provider.dart';
import 'package:final_year_project/UI/pages/Playlists/playlist_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:like_button/like_button.dart';

class PlaylistItemTest extends ConsumerStatefulWidget {
  final PlaylistItem playlist;
  final bool isFavorite;

  const PlaylistItemTest(
      {super.key, required this.playlist, required this.isFavorite});

  @override
  ConsumerState createState() => _PlaylistItemTestState();
}

class _PlaylistItemTestState extends ConsumerState<PlaylistItemTest>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PlaylistDetailsPage(
            playlistItem: widget.playlist,
            isFavorite: widget.isFavorite,
          ),
        ));
      },
      leading: buildCachedNetworkImage(),
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
        widget.playlist.type,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Padding buildTitlePadding() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 8),
      child: Text(
        widget.playlist.name,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  CachedNetworkImage buildCachedNetworkImage() {
    return CachedNetworkImage(
      imageUrl: widget.playlist.images.first.url,
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
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
              .toggleFavorites(widget.playlist.id);
          return !isLiked;
        },
      ),
    );
  }
}
