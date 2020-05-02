part of 'checkin_bloc.dart';

class CheckinState extends Equatable {
  const CheckinState();

  @override
  List<Object> get props => null;
}

class CheckinInitial extends CheckinState {
  @override
  List<Object> get props => [];
}

class LoadingState extends CheckinState {}

class LoadedState extends CheckinState {
  final List<Datum> checkinList;
  LoadedState({@required this.checkinList});
  @override
  List<Object> get props => [checkinList];
}

class SuccessState extends CheckinState {
  final String title;
  final String message;
  SuccessState({@required this.title, @required this.message});
  @override
  List<Object> get props => [title, message];
}

class ErrorState extends CheckinState {
  final String errorTitle;
  final String errorMessage;
  ErrorState({@required this.errorTitle, @required this.errorMessage});
  @override
  List<Object> get props => [errorTitle, errorTitle];
}