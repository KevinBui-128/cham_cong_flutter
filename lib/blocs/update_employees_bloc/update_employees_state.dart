part of 'update_employees_bloc.dart';

class UpdateEmployeesState extends Equatable {
  const UpdateEmployeesState();

  @override
  List<Object> get props => null;
}

class UpdateEmployeesInitial extends UpdateEmployeesState {
  @override
  List<Object> get props => [];
}

class LoadingState extends UpdateEmployeesState {}

class UpdateSuccessState extends UpdateEmployeesState {
  final String title;
  final String message;
  UpdateSuccessState({@required this.title, @required this.message});
  @override
  List<Object> get props => [title, message];
}

class UpdateFailureState extends UpdateEmployeesState {
  final String title;
  final String message;
  UpdateFailureState({@required this.title, @required this.message});
}

class DelSuccessState extends UpdateEmployeesState {
  final String title;
  final String message;
  DelSuccessState({@required this.title, @required this.message});
  @override
  List<Object> get props => [title, message];
}

class ErrorState extends UpdateEmployeesState {
  final String errorTitle;
  final String errorMessage;
  ErrorState({@required this.errorTitle, @required this.errorMessage});
  @override
  List<Object> get props => [errorTitle, errorMessage];
}
