import 'package:fake_vision/models/user.dart';
import 'package:fake_vision/resources/auth_methods.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  //User can be nullable
  User? _user;
  final AuthMethods _authMethods = AuthMethods();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
