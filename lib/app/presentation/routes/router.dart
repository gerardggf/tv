import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../my_app.dart';
import '../modules/favorites/views/favorites_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/movie/views/movie_view.dart';
import '../modules/offline/views/offline_view.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/sign_in/views/sign_in_view.dart';
import 'routes.dart';

mixin RouterMixin on State<MyApp> {
  final router = GoRouter(
    routes: [
      GoRoute(
        name: Routes.home,
        path: '/',
        builder: (_, __) => const HomeView(),
      ),
      GoRoute(
        name: Routes.signIn,
        path: '/sign-in',
        builder: (_, __) => const SignInView(),
      ),
      GoRoute(
        name: Routes.movie,
        path: '/movie/:id',
        builder: (_, state) => MovieView(
          movieId: int.parse(
            state.pathParameters['id']!,
          ),
        ),
      ),
      GoRoute(
        name: Routes.profile,
        path: '/profile',
        builder: (_, __) => const ProfileView(),
      ),
      GoRoute(
        name: Routes.offline,
        path: '/offline',
        builder: (_, __) => const OfflineView(),
      ),
      GoRoute(
        name: Routes.favorites,
        path: '/profile',
        builder: (_, __) => const FavoritesView(),
      ),
    ],
  );
}
