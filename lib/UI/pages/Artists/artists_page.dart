
import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_year_project/DATA/State_Management/api_providers/spotify_api_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArtistsPage extends ConsumerStatefulWidget {
  const ArtistsPage({super.key});

  @override
  ConsumerState createState() => _NetworksPageState();
}

class _NetworksPageState extends ConsumerState<ArtistsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    final artists = ref.watch(artistsProvider);
    return Scaffold(
      body: SafeArea(
        child: artists.when(
          data: (data) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final artist = data[index];
                final artistImage =
                artist.images.isNotEmpty ? artist.images.first.url : '';
                return ListTile(
                  leading: CircleAvatar(
                      foregroundImage: CachedNetworkImageProvider(artistImage),
                      radius: 32),
                  title: Padding(
                    padding: const EdgeInsets.only(top: 8, left: 8),
                    child: Text(
                      artist.name,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 8),
                    child: Text(
                      artist.type,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  onTap: () {},
                  isThreeLine: true,
                );
              },
              itemCount: data.length,
            );
          },
          error: (error, stackTrace) {
            return Center(
              child: Text("Error: $error"),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
