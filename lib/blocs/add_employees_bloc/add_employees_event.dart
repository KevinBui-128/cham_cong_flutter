part of 'add_employees_bloc.dart';

class AddEmployeesEvent extends Equatable {
  const AddEmployeesEvent();

  @override
  List<Object> get props => null;
}

class OnPressButtonEvent extends AddEmployeesEvent {
  final String name;
  final String username;
  final String password;
  final BuildContext context;
  final RegisterStream registerStream;

  OnPressButtonEvent(
      {@required this.name,
      @required this.username,
      @required this.password,
      @required this.context,
      this.registerStream});
  @override
  List<Object> get props => [name, username, password, context, registerStream];
}

class ShowPassEvent extends AddEmployeesEvent {
  final bool showPass;
  ShowPassEvent({@required this.showPass});
  @override
  List<Object> get props => [showPass];
}