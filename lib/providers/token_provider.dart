import 'package:flutter/cupertino.dart';

class AuthToken {
  final String token;

  AuthToken(this.token);
}
class AuthTokenProvider extends ChangeNotifier {
   AuthToken? _token;

  AuthToken get token => _token!;

  void setToken(AuthToken token) {
    _token = token;
    notifyListeners();
  }
}