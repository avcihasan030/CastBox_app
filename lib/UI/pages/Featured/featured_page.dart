
import 'package:final_year_project/DATA/State_Management/api_providers/spotify_api_provider.dart';
import 'package:final_year_project/UI/pages/Featured/playlist_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FeaturedPage extends ConsumerStatefulWidget {
  const FeaturedPage({super.key});

  @override
  ConsumerState createState() => _TestFeaturedPageState();
}

class _TestFeaturedPageState extends ConsumerState<FeaturedPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoriesProvider);

    return categories.when(
      data: (data) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final currentCategory = data[index];
            return PlaylistCard(currentCategory);
          },
          itemCount: 10,
        );
      },
      error: (error, stackTrace) {
        debugPrint("Error: $error");
        return Center(
          child: Text("Error: $error"),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}