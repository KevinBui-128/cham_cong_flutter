part of 'add_employees_bloc.dart';

class AddEmployeesState extends Equatable {
  const AddEmployeesState();

  @override
  List<Object> get props => null;
}

class AddEmployeesInitial extends AddEmployeesState {
  @override
  List<Object> get props => [];
}

class LoadingState extends AddEmployeesState {}

class SuccessState extends AddEmployeesState {
  final String title;
  final String message;
  SuccessState({@required this.title, @required this.message});
  @override
  List<Object> get props => [title, message];
}

class FailureState extends AddEmployeesState {
  final String errorTitle;
  final String errorMessage;
  FailureState({@required this.errorTitle, @required this.errorMessage});
  @override
  List<Object> get props => [errorTitle, errorMessage];
}
