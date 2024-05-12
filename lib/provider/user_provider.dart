import 'package:flutter/material.dart';
import 'package:tinhtoandidong_project/model/user.dart';
import 'package:tinhtoandidong_project/resources/auth_method.dart';

//*https://www.youtube.com/watch?v=K2ampPUTfIQ:definition of provider
class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();
  //*getter
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
    //!notifyListeners() is a method from ChangeNotifier class that notifies all the listeners of the change in the state of the object.
    notifyListeners();
  }
}
