import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _key = 'session_id';
const _accountKey = 'account_id';

class SessionService {
  SessionService(this._secureStorage);

  final FlutterSecureStorage _secureStorage;

  Future<String?> get sessionId {
    return _secureStorage.read(key: _key);
  }

  Future<String?> get accountId {
    return _secureStorage.read(key: _accountKey);
  }

  Future<void> saveSessionId(String sessionId) async {
    return _secureStorage.write(
      key: _key,
      value: sessionId,
    );
  }

  Future<void> saveAccountId(String accountId) async {
    return _secureStorage.write(
      key: _accountKey,
      value: accountId,
    );
  }

  Future<void> signOut() async {
    return _secureStorage.deleteAll();
  }
}
