import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chamcongapp/data/api/registerApi.dart';
import 'package:chamcongapp/streams/registerStream.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  @override
  RegisterState get initialState => RegisterInitial();

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    try {
      if (event is OnPressButtonEvent) {
        yield LoadingState();
        if (event.registerStream.isValidInfo(
            username: event.username.trim(),
            password: event.password.trim(),
            name: event.name.trim())) {
          final result = await postRegister(
              name: event.name.trim(),
              username: event.username.trim(),
              password: event.password.trim());
          if (result == 1) {
            yield SuccessState(
              title: "Thông báo",
              message: "Đăng ký thành công"
            );
          } else {
            yield FailureState(
                errorTitle: "Thông báo", errorMessage: "Đăng ký thất bại");
          }
        } else {
          yield FailureState(
              errorTitle: "Đăng ký thất bại", errorMessage: "Nhập sai dữ liệu");
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
