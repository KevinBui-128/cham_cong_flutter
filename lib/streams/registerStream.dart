import 'dart:async';

import 'package:chamcongapp/validations/validations.dart';

class RegisterStream {
  StreamController _usernameController = StreamController.broadcast();
  StreamController _passController = StreamController.broadcast();
  StreamController _nameController = StreamController.broadcast();
  Stream get usernameStream => _usernameController.stream;
  Stream get passStream => _passController.stream;
  Stream get nameStream => _nameController.stream;

  void userNameChange(String username) {
    if (!Validations.isValidUser(username)) {
      _usernameController.sink
          .addError("Tài khoản phải nhập từ 3 ký tự trở lên");
    }
    else{}
  }

  void passWordChange(String pass) {
    if (!Validations.isValidPass(pass)) {
      _passController.sink.addError("Mật khẩu phải có từ 4-8 ký tự");
    }
    else{}
  }

  void nameChange(String name) {
    if (!Validations.isValidText(name)) {
      _nameController.sink.addError("Tên phải nhập từ 3 ký tự trở lên");
    }
    else{}
  }

  bool isValidInfo({String username, String password, String name}) {
    bool status = true;
    if (!Validations.isValidUser(username)) {
      status = false;
    } else {}
    if (!Validations.isValidPass(password)) {
      status = false;
    } else {}
    if (!Validations.isValidUser(name)) {
      status = false;
    } else {}
    return status;
  }

  void dispose() {
    _nameController.close();
    _passController.close();
    _usernameController.close();
  }
}
