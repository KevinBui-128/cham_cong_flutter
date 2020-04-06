import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chamcongapp/data/api/loginApi.dart';
import 'package:chamcongapp/screens/homeScreen.dart';
import 'package:chamcongapp/streams/loginStream.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    try {
      if (event is OnPressButtonEvent) {
        yield LoadingState();
        if (event.loginStream.isValidInfo(
            username: event.username.trim(), password: event.password.trim())) {
          final result = await postLogin(
              username: event.username.trim(), password: event.password.trim());
          if (result == 1) {
            yield LoginSuccessState();
            Navigator.push(event.context,
                MaterialPageRoute(builder: (context) => HomePage()));
          } else if (result == 2) {
            print("Tài khoản không tồn tại");
            yield LoginFailureState(
                errorTitle: "Thông báo",
                errorMessage: "Tài khoản không tồn tại");
          } else {
            yield LoginFailureState(
                errorTitle: "Thông báo lỗi",
                errorMessage: "Đăng nhập thất bại");
          }
        } else {
          yield LoginFailureState(
              errorTitle: "Thông báo lỗi", errorMessage: "Đăng nhập thất bại");
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
