import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chamcongapp/data/api/registerApi.dart';
import 'package:chamcongapp/streams/registerStream.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'add_employees_event.dart';
part 'add_employees_state.dart';

class AddEmployeesBloc extends Bloc<AddEmployeesEvent, AddEmployeesState> {
  @override
  AddEmployeesState get initialState => AddEmployeesInitial();

  @override
  Stream<AddEmployeesState> mapEventToState(
    AddEmployeesEvent event,
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
            Navigator.pop(event.context);
            yield SuccessState();
          } else if (result == 2) {
            yield FailureState(
                errorTitle: "Đăng ký thật bại",
                errorMessage: "Tài khoản đã tồn tại");
            print("tai khoản tồn tại");
          } else {
            yield FailureState(
                errorTitle: "Đăng ký thất bại", errorMessage: null);
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
