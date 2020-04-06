part of 'employees_bloc.dart';

class EmployeesState extends Equatable {
  const EmployeesState();

  @override
  List<Object> get props => null;
}

class EmployeesInitial extends EmployeesState {
  @override
  List<Object> get props => [];
}

class LoadingState extends EmployeesState {}

class LoadedState extends EmployeesState {
  final List<Employee> employeesList;
  LoadedState({@required this.employeesList});
  @override
  List<Object> get props => [employeesList];
}

class ErrorState extends EmployeesState {
  final String errorTitle;
  final String errorMessage;
  ErrorState({@required this.errorTitle, @required this.errorMessage});
  @override
  List<Object> get props => [errorTitle, errorTitle];
}
