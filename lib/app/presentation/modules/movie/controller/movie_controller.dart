import '../../../../domain/repositories/movies_repository.dart';
import '../../../global/state_notifier.dart';
import 'state/movie_state.dart';

class MovieController extends StateNotifier<MovieState> {
  MovieController(
    super.state, {
    required this.moviesRepository,
    required this.movieId,
  });

  final int movieId;
  final MoviesRepository moviesRepository;

  Future<void> init() async {
    final result = await moviesRepository.getMovieById(movieId);
    state = result.when(
      left: (_) {
        return MovieState.failed();
      },
      right: (movie) {
        return MovieState.loaded(movie);
      },
    );
  }
}
