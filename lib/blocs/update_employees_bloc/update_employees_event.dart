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
  final String address;
  final int phone;
  final BuildContext context;
  final UpdateEmployeesStream updateEmployeesStream;
  OnPressUpdateEvent(
      {@required this.name,
      @required this.username,
      @required this.password,
      @required this.address,
      @required this.phone,
      @required this.context,
      this.updateEmployeesStream});
  @override
  List<Object> get props =>
      [name, username, password, address, phone, context, updateEmployeesStream];
}

class DelButtonEmployeesEvent extends UpdateEmployeesEvent {
  final String username;
  final BuildContext context;
  DelButtonEmployeesEvent(
      {@required this.username,
      @required this.context});
  @override
  List<Object> get props => [username, context];
}
