import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _token = '';
  String _username = '';
  String _email = '';
  String _phoneNumber = '';

  String get token => _token;
  String get username => _username;
  String get email => _email;
  String get phoneNumber => _phoneNumber;

  void setToken(String token) {
    _token = token;
    notifyListeners();
  }

  void setUserDetails(String username, String email, String phoneNumber) {
    _username = username;
    _email = email;
    _phoneNumber = phoneNumber;
    notifyListeners();
  }

  void logout() {
    _token = '';
    _username = '';
    _email = '';
    _phoneNumber = '';
    notifyListeners();
  }
}
