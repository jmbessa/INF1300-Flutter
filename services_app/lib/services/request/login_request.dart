import 'dart:async';

import '../../models/user.dart';
import '../../data/CtrQuery/login_ctrl.dart';

class LoginRequest {
  LoginCtr con = new LoginCtr();

  Future<User?> getLogin(String username, String password) {
    var result = con.getLogin(username, password);
    return result;
  }
}
