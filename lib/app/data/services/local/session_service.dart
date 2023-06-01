import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const sessionIdKey = 'session_id';
const accountKey = 'account_id';

class SessionService {
  SessionService(this._secureStorage);

  final FlutterSecureStorage _secureStorage;

  Future<String?> get sessionId {
    return _secureStorage.read(key: sessionIdKey);
  }

  Future<String?> get accountId {
    return _secureStorage.read(key: accountKey);
  }

  Future<void> saveSessionId(String sessionId) async {
    return _secureStorage.write(
      key: sessionIdKey,
      value: sessionId,
    );
  }

  Future<void> saveAccountId(String accountId) async {
    return _secureStorage.write(
      key: accountKey,
      value: accountId,
    );
  }

  Future<void> signOut() async {
    return _secureStorage.deleteAll();
  }
}
