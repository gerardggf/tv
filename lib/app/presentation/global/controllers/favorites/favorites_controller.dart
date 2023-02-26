import '../../../../domain/models/media/media.dart';
import '../../../../domain/repositories/account_repository.dart';
import '../../state_notifier.dart';
import 'state/favorites_state.dart';

class FavoriteController extends StateNotifier<FavoritesState> {
  FavoriteController(
    super.state, {
    required this.accountRepository,
  });

  final AccountRepository accountRepository;

  Future<void> init() async {
    final moviesResult = await accountRepository.getFavorites(MediaType.movie);

    state = await moviesResult.when(
      left: (_) async => FavoritesState.failed(),
      right: (movies) async {
        final seriesResult = await accountRepository.getFavorites(MediaType.tv);
        return seriesResult.when(
          left: (_) => FavoritesState.failed(),
          right: (series) => FavoritesState.loaded(
            movies: movies,
            series: series,
          ),
        );
      },
    );
  }
}