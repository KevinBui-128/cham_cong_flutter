part of 'register_bloc.dart';

class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => null;
}

class RegisterInitial extends RegisterState {
  @override
  List<Object> get props => [];
}

class LoadingState extends RegisterState {}

class SuccessState extends RegisterState {
  final String title;
  final String message;
  SuccessState({@required this.title, @required this.message});
  @override
  List<Object> get props => [title, message];
}

class FailureState extends RegisterState {
  final String errorTitle;
  final String errorMessage;
  FailureState({@required this.errorTitle, @required this.errorMessage});
  @override
  List<Object> get props => [errorTitle, errorMessage];
}
