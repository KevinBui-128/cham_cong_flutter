part of 'update_employees_bloc.dart';

class UpdateEmployeesEvent extends Equatable {
  const UpdateEmployeesEvent();

  @override
  List<Object> get props => null;
}

class OnPressUpdateEvent extends UpdateEmployeesEvent {
  final String name;
  final String username;
  final String password;
  final BuildContext context;
  final UpdateEmployeesStream updateEmployeesStream;
  OnPressUpdateEvent(
      {@required this.name,
      @required this.username,
      @required this.password,
      @required this.context,
      this.updateEmployeesStream});
  @override
  List<Object> get props =>
      [name, username, password, context, updateEmployeesStream];
}

class DelButtonEmployeesEvent extends UpdateEmployeesEvent {
  final String username;
  final String name;
  final String password;
  DelButtonEmployeesEvent(
      {@required this.username, @required this.name, @required this.password});
  @override
  List<Object> get props => [username, name, password];
}
