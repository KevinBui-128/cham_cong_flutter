import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chamcongapp/data/api/employeesApi.dart';
import 'package:chamcongapp/data/model/employeesModel.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'employees_event.dart';
part 'employees_state.dart';

class EmployeesBloc extends Bloc<EmployeesEvent, EmployeesState> {
  @override
  EmployeesState get initialState => EmployeesInitial();

  @override
  Stream<EmployeesState> mapEventToState(
    EmployeesEvent event,
  ) async* {
    try {
      if (event is LoadEmployeesEvent) {
        yield LoadingState();
        EmployeesModel employeesModel = await getEmployees();

        if (employeesModel?.employees != null) {
          yield LoadedState(employeesList: employeesModel.employees);
        } else {
          yield ErrorState(
              errorTitle: "Thông báo lỗi", errorMessage: "Lỗi không xác định");
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
