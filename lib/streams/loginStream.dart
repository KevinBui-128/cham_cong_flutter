import 'dart:async';

import 'package:chamcongapp/validations/validations.dart';

class LoginStream {
  StreamController _userController = StreamController.broadcast();
  StreamController _passController = StreamController.broadcast();
  Stream get usernameStream => _userController.stream;
  Stream get passwordStream => _passController.stream;

  void usernameChange(String username) {
    if (!Validations.isValidUser(username)) {
      _userController.sink.addError("Tài khoản phải nhập từ 3 ký tự trở lên");
    } else {
    }
  }
  void passwordChange(String password){
    if (!Validations.isValidPass(password)) {
      _passController.sink.addError("Mật khẩu phải có từ 4-8 ký tự");
    } else {
    }
  }

  bool isValidInfo({String username, String password}) {
    bool status = true;
    if (!Validations.isValidUser(username)) {
      status = false;
    } else {}
    if (!Validations.isValidPass(password)) {
      status = false;
    } else {}
    return status;
  }

  void dispose() {
    _passController.close();
    _userController.close();
  }
}
