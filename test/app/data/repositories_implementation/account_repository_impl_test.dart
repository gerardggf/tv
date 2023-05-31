import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:tv/app/data/http/http.dart';
import 'package:tv/app/data/repositories_implementation/account_repository_impl.dart';
import 'package:tv/app/data/services/local/language_service.dart';
import 'package:tv/app/data/services/local/session_service.dart';
import 'package:tv/app/data/services/remote/account_api.dart';

void main() {
  test(
    'AccountRepositoryImpl',
    () async {
      final sessionService = SessionService(
        MockFlutterSecureStorage(),
      );
      final accountApi = AccountAPI(
        Http(
          client: MockClient(),
          baseUrl: 'https://api.themoviedb.org/3',
          apiKey: 'f41a23c2b3c209cdb9845a666c1143b5',
        ),
        sessionService,
        LanguageService('en'),
      );

      final repo = AccountRepositoryImpl(
        accountApi,
        sessionService,
      );

      final user = await repo.getUserData();
      expect(user, isNotNull);
    },
  );
}

class MockClient implements Client {
  @override
  void close() {
    // TODO: implement close
  }

  @override
  Future<Response> delete(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Response> get(Uri url, {Map<String, String>? headers}) {
    return Future.value(
      Response(
        jsonEncode(
          {
            'id': 0,
            'username': 'Darwin',
            'avatar': {
              'tmdb': {
                'avatar_path': '/tahdh.png',
              },
            },
          },
        ),
        200,
      ),
    );
  }

  @override
  Future<Response> head(Uri url, {Map<String, String>? headers}) {
    // TODO: implement head
    throw UnimplementedError();
  }

  @override
  Future<Response> patch(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    // TODO: implement patch
    throw UnimplementedError();
  }

  @override
  Future<Response> post(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    // TODO: implement post
    throw UnimplementedError();
  }

  @override
  Future<Response> put(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    // TODO: implement put
    throw UnimplementedError();
  }

  @override
  Future<String> read(Uri url, {Map<String, String>? headers}) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<Uint8List> readBytes(Uri url, {Map<String, String>? headers}) {
    // TODO: implement readBytes
    throw UnimplementedError();
  }

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    // TODO: implement send
    throw UnimplementedError();
  }
}

class MockFlutterSecureStorage implements FlutterSecureStorage {
  @override
  // TODO: implement aOptions
  AndroidOptions get aOptions => throw UnimplementedError();

  @override
  Future<bool> containsKey(
      {required String key,
      IOSOptions? iOptions,
      AndroidOptions? aOptions,
      LinuxOptions? lOptions,
      WebOptions? webOptions,
      MacOsOptions? mOptions,
      WindowsOptions? wOptions}) {
    // TODO: implement containsKey
    throw UnimplementedError();
  }

  @override
  Future<void> delete(
      {required String key,
      IOSOptions? iOptions,
      AndroidOptions? aOptions,
      LinuxOptions? lOptions,
      WebOptions? webOptions,
      MacOsOptions? mOptions,
      WindowsOptions? wOptions}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAll(
      {IOSOptions? iOptions,
      AndroidOptions? aOptions,
      LinuxOptions? lOptions,
      WebOptions? webOptions,
      MacOsOptions? mOptions,
      WindowsOptions? wOptions}) {
    // TODO: implement deleteAll
    throw UnimplementedError();
  }

  @override
  // TODO: implement iOptions
  IOSOptions get iOptions => throw UnimplementedError();

  @override
  // TODO: implement lOptions
  LinuxOptions get lOptions => throw UnimplementedError();

  @override
  // TODO: implement mOptions
  MacOsOptions get mOptions => throw UnimplementedError();

  @override
  Future<String?> read(
      {required String key,
      IOSOptions? iOptions,
      AndroidOptions? aOptions,
      LinuxOptions? lOptions,
      WebOptions? webOptions,
      MacOsOptions? mOptions,
      WindowsOptions? wOptions}) {
    return Future.value(null);
  }

  @override
  Future<Map<String, String>> readAll(
      {IOSOptions? iOptions,
      AndroidOptions? aOptions,
      LinuxOptions? lOptions,
      WebOptions? webOptions,
      MacOsOptions? mOptions,
      WindowsOptions? wOptions}) {
    // TODO: implement readAll
    throw UnimplementedError();
  }

  @override
  // TODO: implement wOptions
  WindowsOptions get wOptions => throw UnimplementedError();

  @override
  // TODO: implement webOptions
  WebOptions get webOptions => throw UnimplementedError();

  @override
  Future<void> write(
      {required String key,
      required String? value,
      IOSOptions? iOptions,
      AndroidOptions? aOptions,
      LinuxOptions? lOptions,
      WebOptions? webOptions,
      MacOsOptions? mOptions,
      WindowsOptions? wOptions}) {
    return Future.value();
  }
}
