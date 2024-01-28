import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_year_project/DATA/State_Management/api_providers/spotify_api_provider.dart';
import 'package:final_year_project/UI/pages/Categories/category_playlists_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesPage extends ConsumerWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fetchCategories = ref.watch(categoriesProvider);
    return Scaffold(
      body: fetchCategories.when(
        data: (data) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final category = data[index];
              final bool categoryIconStatus = category.icons.isNotEmpty;
              return ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CategoryPlaylistsPage(category),
                    ),
                  );
                },
                title: Text(category.name),
                leading: Padding(
                  padding: const EdgeInsets.only(top: 2, bottom: 2),
                  child: Container(
                    child: categoryIconStatus
                        ? CachedNetworkImage(
                      imageUrl: category.icons.first.url.toString(),
                      placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                      const Icon(Icons.error),
                    )
                        : const Icon(Icons.category_outlined),
                  ),
                ),
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
    );
  }
}
