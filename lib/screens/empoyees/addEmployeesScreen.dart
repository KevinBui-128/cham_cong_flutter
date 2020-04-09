import 'package:chamcongapp/blocs/add_employees_bloc/add_employees_bloc.dart';
import 'package:chamcongapp/streams/registerStream.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEmployeesPage extends StatefulWidget {
  @override
  _AddEmployeesPageState createState() => _AddEmployeesPageState();
}

class _AddEmployeesPageState extends State<AddEmployeesPage> {
  TextEditingController _user = TextEditingController();
  TextEditingController _pass = TextEditingController();
  TextEditingController _name = TextEditingController();
  RegisterStream registerStream;
  final FocusNode _userName = FocusNode();
  final FocusNode _passWord = FocusNode();
  final FocusNode _fullName = FocusNode();

  @override
  void initState() {
    registerStream = RegisterStream();
    super.initState();
  }

  @override
  void dispose() {
    registerStream.dispose();
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
        title: Text('Đăng ký'),
      ),
      body: SingleChildScrollView(
        child: BlocProvider(
          builder: (context) => AddEmployeesBloc(),
          child: BlocListener<AddEmployeesBloc, AddEmployeesState>(
            listener: (context, state) {
              if (state is FailureState) {
                _diaLog(state.errorTitle, state.errorMessage);
              }
            },
            child: BlocBuilder<AddEmployeesBloc, AddEmployeesState>(
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
                        'Đăng ký thành viên',
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
                        stream: registerStream.usernameStream,
                        builder: (context, snapshot) => TextField(
                          focusNode: _userName,
                          onSubmitted: (va) {
                            _fieldFocusChange(context, _userName, _passWord);
                          },
                          controller: _user,
                          onChanged: (va) {
                            registerStream.userNameChange(va);
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
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                      child: StreamBuilder(
                        stream: registerStream.passStream,
                        builder: (context, snapshot) => TextField(
                          focusNode: _passWord,
                          controller: _pass,
                          onChanged: (va) {
                            registerStream.passWordChange(va);
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
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                      child: StreamBuilder(
                        stream: registerStream.nameStream,
                        builder: (context, snapshot) => TextField(
                          focusNode: _fullName,
                          controller: _name,
                          onChanged: (va) {
                            registerStream.nameChange(va);
                          },
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          decoration: InputDecoration(
                              labelText: 'Họ và tên',
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
                            BlocProvider.of<AddEmployeesBloc>(context).add(
                              OnPressButtonEvent(
                                  context: context,
                                  username: _user.text,
                                  password: _pass.text,
                                  name: _name.text,
                                  registerStream: registerStream),
                            );
                          },
                          color: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Text(
                            'Đăng ký',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
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