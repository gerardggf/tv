import 'dart:ui' as ui;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/data/http/http.dart';
import 'app/data/repositories_implementation/account_repository_impl.dart';
import 'app/data/repositories_implementation/authentication_repostory_impl.dart';
import 'app/data/repositories_implementation/connectivity_repostory_impl.dart';
import 'app/data/repositories_implementation/movies_repository_impl.dart';
import 'app/data/repositories_implementation/preferences_repository_impl.dart';
import 'app/data/repositories_implementation/trending_repository_impl.dart';
import 'app/data/services/local/session_service.dart';
import 'app/data/services/remote/account_api.dart';
import 'app/data/services/remote/authentication_api.dart';
import 'app/data/services/remote/internet_checker.dart';
import 'app/data/services/remote/movies_api.dart';
import 'app/data/services/remote/trending_api.dart';
import 'app/domain/repositories/account_repository.dart';
import 'app/domain/repositories/authentication_repository.dart';
import 'app/domain/repositories/connectivity_repository.dart';
import 'app/domain/repositories/movies_repository.dart';
import 'app/domain/repositories/preference_repository.dart';
import 'app/domain/repositories/trending_repository.dart';
import 'app/my_app.dart';
import 'app/presentation/global/controllers/favorites/favorites_controller.dart';
import 'app/presentation/global/controllers/favorites/state/favorites_state.dart';
import 'app/presentation/global/controllers/session_controller.dart';
import 'app/presentation/global/controllers/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sessionService = SessionService(
    const FlutterSecureStorage(),
  );
  final http = Http(
    client: Client(),
    baseUrl: 'https://api.themoviedb.org/3',
    apiKey: 'f41a23c2b3c209cdb9845a666c1143b5',
  );
  final accountAPI = AccountAPI(http, sessionService);

  final systemDarkMode = ui.window.platformBrightness == Brightness.dark;

  final preferences = await SharedPreferences.getInstance();

  final connectivity = ConnectivityRepositoryImpl(
    Connectivity(),
    InternetChecker(),
  );
  await connectivity.initialize();

  runApp(
    MultiProvider(
      providers: [
        Provider<PreferencesRepository>(
          create: (_) {
            return PreferencesRepositoryImpl(preferences);
          },
        ),
        Provider<AccountRepository>(
          create: (_) {
            return AccountRepositoryImpl(
              accountAPI,
              sessionService,
            );
          },
        ),
        Provider<ConnectivityRepository>(
          create: (_) => connectivity,
        ),
        Provider<AuthenticationRepository>(
          create: (_) {
            return AuthenticationRepositoryImpl(
              AuthenticationAPI(http),
              sessionService,
              accountAPI,
            );
          },
        ),
        Provider<TrendingRepository>(
          create: (_) {
            return TrendingRepositoryImpl(
              TrendingAPI(http),
            );
          },
        ),
        Provider<MoviesRepository>(
          create: (_) {
            return MoviesRepositoryImpl(
              MoviesAPI(http),
            );
          },
        ),
        ChangeNotifierProvider<ThemeController>(
          create: (context) {
            final PreferencesRepository preferencesRepository = context.read();
            return ThemeController(
              preferencesRepository.darkMode ?? systemDarkMode,
              preferencesRepository: preferencesRepository,
            );
          },
        ),
        ChangeNotifierProvider<SessionController>(
          create: (context) => SessionController(
            authenticationRepository: context.read(),
          ),
        ),
        ChangeNotifierProvider<FavoritesController>(
          create: (context) => FavoritesController(
            FavoritesState.loading(),
            accountRepository: context.read(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
