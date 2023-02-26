import 'package:flutter/material.dart';

import '../modules/favorites/views/favorites_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/movie/views/movie_view.dart';
import '../modules/offline/views/offline.dart';
import '../modules/sign_in/views/sign_in_view.dart';
import '../modules/splash/views/splash_view.dart';
import 'routes.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.home: (context) => const HomeView(),
    Routes.splash: (context) => const SplashView(),
    Routes.signIn: (context) => const SignInView(),
    Routes.offline: (context) => const OfflineView(),
    Routes.movie: (context) => MoviewView(
          movieId: ModalRoute.of(context)?.settings.arguments as int,
        ),
    Routes.favorites: (context) => const FavoritesView(),
  };
}
