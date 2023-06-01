import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/app/data/http/http.dart';
import 'package:tv/app/data/repositories_implementation/authentication_repostory_impl.dart';
import 'package:tv/app/data/services/local/language_service.dart';
import 'package:tv/app/data/services/local/session_service.dart';
import 'package:tv/app/data/services/remote/account_api.dart';
import 'package:tv/app/data/services/remote/authentication_api.dart';

import '../../../mocks.dart';

void main() {
  group(
    'AuthenticationRepositotyImpl >',
    () {
      late AuthenticationRepositoryImpl repository;
      late MockFlutterSecureStorage secureStorage;
      late MockClient client;
      setUp(
        () {
          secureStorage = MockFlutterSecureStorage();
          client = MockClient();

          final sessionService = SessionService(secureStorage);
          final http = Http(
            client: client,
            baseUrl: 'baseUrl',
            apiKey: 'apiKey',
          );
          final authenticationApi = AuthenticationAPI(http);
          final accountApi = AccountAPI(
            http,
            sessionService,
            LanguageService(
              'es',
            ),
          );

          repository = AuthenticationRepositoryImpl(
            authenticationApi,
            sessionService,
            accountApi,
          );
        },
      );
      test(
        'isSignedIn > true',
        () async {
          String? sessionId = 'alals';
          when(
            secureStorage.read(
              key: anyNamed('key'),
            ),
          ).thenAnswer(
            (_) async {
              return sessionId;
            },
          );

          when(
            secureStorage.deleteAll(),
          ).thenAnswer(
            (realInvocation) async {
              sessionId = null;
              return;
            },
          );

          expect(await repository.isSignedIn, true);

          await repository.signOut();

          expect(await repository.isSignedIn, false);
        },
      );
    },
  );
}
