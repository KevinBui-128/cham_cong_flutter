import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chamcongapp/configs/config.dart';
import 'package:chamcongapp/data/api/delEmployeesApi.dart';
import 'package:chamcongapp/data/api/updateEmployeesApi.dart';
import 'package:chamcongapp/streams/updateEmployeesStream.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'update_employees_event.dart';
part 'update_employees_state.dart';

class UpdateEmployeesBloc
    extends Bloc<UpdateEmployeesEvent, UpdateEmployeesState> {
  @override
  UpdateEmployeesState get initialState => UpdateEmployeesInitial();

  @override
  Stream<UpdateEmployeesState> mapEventToState(
    UpdateEmployeesEvent event,
  ) async* {
    try {
      if (event is OnPressUpdateEvent) {
        yield LoadingState();
        if (event.updateEmployeesStream.isValidInfo(
            name: event.name,
            username: event.username,
            password: event.password)) {
          final result = await postUpdateEmployees(
              username: event.username,
              name: event.name,
              password: event.password);
          if (result == 1) {
            yield UpdateSuccessState();
          } else if (result == 2) {
            yield UpdateFailureState(
                title: "Thông báo", message: "Lỗi cập nhất");
          } else {
            yield ErrorState(
                errorTitle: "Thông báo lỗi", errorMessage: "Cập nhật thất bại");
          }
        }
      } else if (event is DelButtonEmployeesEvent) {
        final result = await delEmployees(
            username: event.username.trim(),
            password: event.password.trim(),
            name: event.name.trim());
        if (result == 1) {
          yield DelSuccessState(title: "Thông báo", message: "Xóa thành công");
        } else {
          yield ErrorState(
              errorTitle: "Thông báo lỗi", errorMessage: "Xóa thất bại");
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
