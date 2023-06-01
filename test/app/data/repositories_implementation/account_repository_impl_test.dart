import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/app/data/http/http.dart';
import 'package:tv/app/data/repositories_implementation/account_repository_impl.dart';
import 'package:tv/app/data/services/local/language_service.dart';
import 'package:tv/app/data/services/local/session_service.dart';
import 'package:tv/app/data/services/remote/account_api.dart';
import 'package:tv/app/domain/failures/http_request/http_request_failure.dart';
import 'package:tv/app/domain/models/media/media.dart';
import 'package:tv/app/domain/repositories/account_repository.dart';

import '../../../mocks.dart';

void main() {
  late MockClient client;
  late MockFlutterSecureStorage secureStorage;

  late AccountRepository repository;
  setUp(
    () {
      client = MockClient();
      secureStorage = MockFlutterSecureStorage();

      final sessionService = SessionService(
        secureStorage,
      );
      final accountApi = AccountAPI(
        Http(
          client: client,
          baseUrl: 'https://api.themoviedb.org/3',
          apiKey: 'f41a23c2b3c209cdb9845a666c1143b5',
        ),
        sessionService,
        LanguageService('en'),
      );

      repository = AccountRepositoryImpl(
        accountApi,
        sessionService,
      );
    },
  );

  void mockGet({
    required int statusCode,
    required Map<String, dynamic> json,
  }) {
    when(
      client.get(
        any,
        headers: anyNamed('headers'),
      ),
    ).thenAnswer(
      (_) async => Response(
        jsonEncode(
          json,
        ),
        statusCode,
      ),
    );
  }

  test(
    'AccountRepositoryImpl > getUserData',
    () async {
      when(
        secureStorage.read(key: sessionIdKey),
      ).thenAnswer(
        (_) => Future.value('sessionId'),
      );

      mockGet(
        statusCode: 200,
        json: {
          'id': 123,
          'username': 'darwin',
          'avatar': {},
        },
      );

      final user = await repository.getUserData();
      expect(user, isNotNull);
    },
  );

  test(
    'AccountRepositoryImpl > getFavorites > fail',
    () async {
      mockGet(
        statusCode: 401,
        json: {
          'status_code': 3,
          'status_message': '',
        },
      );

      final result = await repository.getFavorites(
        MediaType.movie,
      );
      expect(
        result.value is HttpRequestFailure,
        true,
      );

      expect(
        result.value,
        isA<HttpRequestFailure>(),
      );
    },
  );

  test(
    'AccountRepositoryImpl > getFavorites > success',
    () async {
      mockGet(
        statusCode: 200,
        json: {
          'page': 1,
          'results': [
            {
              'backdrop_path': '/mWGLIaVFXyalsSbstiwletjKFUC.jpg',
              'genre_ids': [18, 80],
              'id': 31586,
              'origin_country': ['US'],
              'original_language': 'es',
              'original_name': 'La Reina del Sur',
              'overview': '',
              'popularity': 98.377,
              'poster_path': '/p11t8ckTC6EiuVw5FGFKdc2Z7GH.jpg',
              'first_air_date': '2011-02-28',
              'name': 'La Reina del Sur',
              'vote_average': 7.839,
              'vote_count': 1736,
            },
          ],
          'total_pages': 3,
          'total_results': 52,
        },
      );

      final result = await repository.getFavorites(
        MediaType.movie,
      );

      expect(
        result.value,
        isA<Map<int, Media>>(),
      );
    },
  );

  test(
    'AccountRepositoryImpl > markAsFavorite > success',
    () async {
      when(
        client.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer(
        (_) async {
          return Response(
              jsonEncode(
                {
                  'status_code': 12,
                  'status_message': '',
                },
              ),
              201);
        },
      );
      final result = await repository.markAsFavorite(
        mediaId: 1234,
        type: MediaType.movie,
        favorite: true,
      );

      expect(
        result.value,
        isA(),
      );
    },
  );

  test(
    'AccountRepositoryImpl > markAsFavorite > fail',
    () async {
      when(
        client.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer(
        (_) async {
          return Response(
            jsonEncode(
              {
                'status_code': 34,
                'status_message': '',
              },
            ),
            404,
          );
        },
      );
      final result = await repository.markAsFavorite(
        mediaId: 1234,
        type: MediaType.movie,
        favorite: true,
      );

      expect(
        result.value is HttpRequestFailure,
        true,
      );
    },
  );
}
