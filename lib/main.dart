import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'app/data/http/http.dart';
import 'app/data/repositories_implementation/account_repository_impl.dart';
import 'app/data/repositories_implementation/authentication_repostory_impl.dart';
import 'app/data/repositories_implementation/connectivity_repostory_impl.dart';
import 'app/data/services/local/session_service.dart';
import 'app/data/services/remote/account_api.dart';
import 'app/data/services/remote/authentication_api.dart';
import 'app/data/services/remote/internet_checker.dart';
import 'app/domain/repositories/account_repository.dart';
import 'app/domain/repositories/authentication_repository.dart';
import 'app/domain/repositories/connectivity_repository.dart';
import 'app/my_app.dart';
import 'app/presentation/global/controllers/session_controller.dart';

void main() {
  final sessionService = SessionService(
    const FlutterSecureStorage(),
  );
  final http = Http(
    client: Client(),
    baseUrl: 'https://api.themoviedb.org/3',
    apiKey: 'f41a23c2b3c209cdb9845a666c1143b5',
  );
  final accountAPI = AccountAPI(http);

  runApp(
    MultiProvider(
      providers: [
        Provider<AccountRepository>(
          create: (_) {
            return AccountRepositoryImpl(
              accountAPI,
              sessionService,
            );
          },
        ),
        Provider<ConnectivityRepository>(
          create: (_) {
            return ConnectivityRepositoryImpl(
              Connectivity(),
              InternetChecker(),
            );
          },
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
        ChangeNotifierProvider<SessionController>(
          create: (_) => SessionController(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
