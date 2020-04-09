import 'dart:async';

import 'package:chamcongapp/validations/validations.dart';

class UpdateEmployeesStream {
  StreamController _user = StreamController.broadcast();
  StreamController _pass = StreamController.broadcast();
  StreamController _name = StreamController.broadcast();
  Stream get usernameStream => _user.stream;
  Stream get passwordStream => _pass.stream;
  Stream get nameStream => _name.stream;

  void usernameChange(String username) {
    if (!Validations.isValidUser(username)) {
      _user.sink.addError("error");
    } else {
      _user.sink.add("ok");
    }
  }

  void passwordChagne(String password) {
    if (!Validations.isValidPass(password)) {
      _pass.sink.addError("error");
    } else {
      _pass.sink.add("ok");
    }
  }

  void nameChange(String name) {
    if (!Validations.isValidUser(name)) {
      _name.sink.addError("error");
    } else {
      _name.sink.add("ok");
    }
  }

  bool isValidInfo({String name, String username, String password}) {
    bool status = true;
    if (!Validations.isValidUser(username)) {
      status = false;
    } else if (!Validations.isValidPass(password)) {
      status = false;
    } else if (!Validations.isValidText(name)) {
      status = false;
    }
    return status;
  }

  void dispose() {
    _user.close();
    _pass.close();
    _name.close();
  }
}
