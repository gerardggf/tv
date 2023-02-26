import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../global/controllers/favorites/favorites_controller.dart';
import '../../controller/movie_controller.dart';

class MovieAppBar extends StatelessWidget with PreferredSizeWidget {
  const MovieAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final MovieController controller = context.watch();
    final FavoriteController favoriteController = context.watch();

    return AppBar(
      backgroundColor: Colors.transparent,
      actions: controller.state.mapOrNull(
        loaded: (movieState) => [
          favoriteController.state.maybeMap(
            orElse: () => const SizedBox(),
            loaded: (favoriteState) => IconButton(
              onPressed: () {},
              icon: Icon(
                favoriteState.movies.containsKey(movieState.movie.id)
                    ? Icons.favorite
                    : Icons.favorite_outline,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
