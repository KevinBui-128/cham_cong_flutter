import 'package:chamcongapp/blocs/login_bloc/login_bloc.dart';
import 'package:chamcongapp/screens/registerScreen.dart';
import 'package:chamcongapp/streams/loginStream.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _user = TextEditingController();
  TextEditingController _pass = TextEditingController();
  LoginStream loginStream;
  final FocusNode _userName = FocusNode();
  final FocusNode _passWord = FocusNode();

  @override
  void initState() {
    loginStream = LoginStream();
    super.initState();
  }

  @override
  void dispose() {
    loginStream.dispose();
    super.dispose();
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đăng nhập'),
      ),
      body: SingleChildScrollView(
        child: BlocProvider(
          builder: (context) => LoginBloc(),
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginFailureState) {
                _diaLog(state.errorTitle, state.errorMessage);
              }
            },
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return Container(
                  padding: EdgeInsets.fromLTRB(30, 100, 30, 10),
                  color: Colors.white30,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Text(
                          'Đăng nhập để chấm công',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 25),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                        child: StreamBuilder(
                          stream: loginStream.usernameStream,
                          builder: (context, snapshot) => TextField(
                            focusNode: _userName,
                            onSubmitted: (va) {
                              _fieldFocusChange(context, _userName, _passWord);
                            },
                            controller: _user,
                            onChanged: (va) {
                              loginStream.usernameChange(va);
                            },
                            style: TextStyle(fontSize: 18, color: Colors.black),
                            decoration: InputDecoration(
                                labelText: 'Tài khoản',
                                errorText:
                                    snapshot.hasError ? snapshot.error : null,
                                labelStyle: TextStyle(
                                    color: Color(0xffd888888), fontSize: 15)),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 35),
                        child: StreamBuilder(
                          stream: loginStream.passwordStream,
                          builder: (context, snapshot) => TextField(
                            focusNode: _passWord,
                            controller: _pass,
                            onChanged: (va) {
                              loginStream.passwordChange(va);
                            },
                            obscureText: true,
                            style: TextStyle(fontSize: 18, color: Colors.black),
                            decoration: InputDecoration(
                                labelText: 'Mật khẩu',
                                errorText:
                                    snapshot.hasError ? snapshot.error : null,
                                labelStyle: TextStyle(
                                    color: Color(0xffd888888), fontSize: 15)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                        child: SizedBox(
                          height: 56,
                          width: double.infinity,
                          child: RaisedButton(
                            onPressed: () {
                              BlocProvider.of<LoginBloc>(context).add(
                                OnPressButtonEvent(
                                    context: context,
                                    username: _user.text,
                                    password: _pass.text,
                                    loginStream: loginStream),
                              );
                            },
                            color: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Text(
                              'Đăng nhập',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: SizedBox(
                          height: 56,
                          width: double.infinity,
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterPage()));
                            },
                            color: Colors.black26,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Text(
                              'Đăng ký',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _diaLog(String title, String message) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        FlatButton(
          child: Text('Ok'),
          onPressed: () {},
        )
      ],
    );
  }
}
