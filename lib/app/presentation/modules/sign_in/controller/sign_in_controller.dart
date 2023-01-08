import 'package:flutter/foundation.dart';

class SignInController extends ChangeNotifier {
  String _username = "", _password = "";
  bool _fetching = false;

  String get username => _username;
  String get password => _password;
  bool get fetching => _fetching;

  void onUsernameChanged(String text) {
    _username = text.trim().toLowerCase();
  }

  void onPasswordChanged(String text) {
    _password = text.replaceAll(" ", "");
  }

  void onFetchingChanged(bool value) {
    _fetching = value;
    notifyListeners();
  }
}
