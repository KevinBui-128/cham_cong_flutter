part of 'calendar_bloc.dart';

class CalendarState extends Equatable {
  const CalendarState();

  @override
  List<Object> get props => null;
}

class CalendarInitial extends CalendarState {
  @override
  List<Object> get props => [];
}

class LoadingState extends CalendarState {}

class LoadedState extends CalendarState {
  final List<Datum> calendarList;
  LoadedState({@required this.calendarList});
  @override
  List<Object> get props => [calendarList];
}

class SuccessState extends CalendarState {
  final String title;
  final String message;
  SuccessState({@required this.title, @required this.message});
  @override
  List<Object> get props => [title, message];
}

class UpdateFailureState extends CalendarState {
  final String title;
  final String message;
  UpdateFailureState({@required this.title, @required this.message});
}

class ErrorState extends CalendarState {
  final String errorTitle;
  final String errorMessage;
  ErrorState({@required this.errorTitle, @required this.errorMessage});
  @override
  List<Object> get props => [errorTitle, errorTitle];
}
