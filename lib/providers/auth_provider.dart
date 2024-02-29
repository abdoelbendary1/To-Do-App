import 'package:flutter/cupertino.dart';
import 'package:todo_app1/model/user.dart';

class AuthinticationProvider extends ChangeNotifier {
  MyUser? currentUser;

  void updateUser(MyUser? newUser) {
    currentUser = newUser;
    notifyListeners();
  }
}
