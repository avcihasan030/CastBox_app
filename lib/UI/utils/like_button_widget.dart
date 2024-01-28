import 'package:final_year_project/DATA/State_Management/widget_providers/favorites_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:like_button/like_button.dart';

class LikeButtonWidget extends ConsumerStatefulWidget {
  final String playlistId;
  final bool isFavorite;
  const LikeButtonWidget(this.playlistId, this.isFavorite, {super.key});

  @override
  ConsumerState createState() => _LikeButtonWidgetState();
}

class _LikeButtonWidgetState extends ConsumerState<LikeButtonWidget> {
  @override
  Widget build(BuildContext context) {
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
              .toggleFavorites(widget.playlistId);
          return !isLiked;
        },
      ),
    );
  }
}

// class LikeButtonWidget extends ConsumerWidget {
//   final String playlistId;
//   final bool isFavorite;
//   const LikeButtonWidget(this.playlistId, this.isFavorite, {super.key});
//
//   @override
//   Widget build(BuildContext context,WidgetRef ref) {
//       return SizedBox(
//         height: 50,
//         width: 50,
//         child: LikeButton(
//           isLiked: isFavorite,
//           size: 28,
//           circleColor:
//           const CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
//           bubblesColor: const BubblesColor(
//             dotPrimaryColor: Color(0xff33b5e5),
//             dotSecondaryColor: Color(0xff0099cc),
//           ),
//           onTap: (isLiked) async {
//             ref
//                 .read(favoritesProvider.notifier)
//                 .toggleFavorites(playlistId);
//             return !isLiked;
//           },
//         ),
//       );
//   }
// }
