part of 'login_bloc.dart';

class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => null;
}

class OnPressButtonEvent extends LoginEvent {
  final String username;
  final String password;
  final BuildContext context;
  final LoginStream loginStream;
  OnPressButtonEvent(
      {@required this.username,
      @required this.password,
      @required this.context,
      this.loginStream});
  @override
  List<Object> get props => [username, password];
}

class ShowPasswordEvent extends LoginEvent {
  final bool showPass;
  ShowPasswordEvent({@required this.showPass});
  List<Object> get props => [showPass];
}
