import 'package:flutter/material.dart';
import 'package:tinhtoandidong_project/model/user.dart';
import 'package:tinhtoandidong_project/resources/auth_method.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();
  User get getUser =>
      _user ??
      User(
          email: '',
          uid: '',
          username: '',
          phone: '',
          favorite: [],
          photoUrl: '');

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
