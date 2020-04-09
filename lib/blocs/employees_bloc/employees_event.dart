part of 'employees_bloc.dart';

class EmployeesEvent extends Equatable {
  const EmployeesEvent();

  @override
  List<Object> get props => null;
}

class LoadEmployeesEvent extends EmployeesEvent {}

class OnReFreshEmployeesEvent extends EmployeesEvent {}


