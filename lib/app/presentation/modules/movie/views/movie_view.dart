import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../global/widgets/request_fail.dart';
import '../controller/movie_controller.dart';
import '../controller/state/movie_state.dart';
import 'widgets/movie_content.dart';

class MoviewView extends StatelessWidget {
  const MoviewView({
    super.key,
    required this.movieId,
  });

  final int movieId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MovieController(
        MovieState.loading(),
        moviesRepository: context.read(),
        movieId: movieId,
      )..init(),
      builder: (context, _) {
        final MovieController controller = context.watch();
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            actions: controller.state.mapOrNull(
              loaded: (_) => [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite_outline),
                ),
              ],
            ),
          ),
          body: controller.state.map(
            loading: (_) => const Center(
              child: CircularProgressIndicator(),
            ),
            failed: (_) => RequestFail(
              onRetry: () {
                controller.init();
              },
            ),
            loaded: (state) => MovieContent(
              state: state,
            ),
          ),
        );
      },
    );
  }
}
