import 'package:chamcongapp/blocs/register_bloc/register_bloc.dart';
import 'package:chamcongapp/streams/registerStream.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _user = TextEditingController();
  TextEditingController _pass = TextEditingController();
  TextEditingController _name = TextEditingController();
  RegisterStream registerStream;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đăng ký'),
      ),
      body: SingleChildScrollView(
        child: Container(
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
                    child: TextField(
                      controller: _user,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      decoration: InputDecoration(
                          labelText: 'Tài khoản',
                          labelStyle: TextStyle(
                              color: Color(0xffd888888), fontSize: 15)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                    child: TextField(
                      controller: _pass,
                      obscureText: true,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      decoration: InputDecoration(
                          labelText: 'Mật khẩu',
                          labelStyle: TextStyle(
                              color: Color(0xffd888888), fontSize: 15)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                    child: TextField(
                      controller: _name,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      decoration: InputDecoration(
                          labelText: 'Họ và tên',
                          labelStyle: TextStyle(
                              color: Color(0xffd888888), fontSize: 15)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                    child: SizedBox(
                      height: 56,
                      width: double.infinity,
                      child: RaisedButton(
                        onPressed: () {
                          // BlocProvider.of<RegisterBloc>(context).add(
                          //   OnPressButtonEvent(
                          //       context: context,
                          //       username: _user.text,
                          //       password: _pass.text,
                          //       name: _name.text,
                          //       registerStream: registerStream),
                          // );
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
            ),

        // BlocProvider(
        //   builder: (context) => RegisterBloc(),
        //   child: BlocListener<RegisterBloc, RegisterState>(
        //     listener: (context, state) {
        //       if (state is FailureState) {
        //         diaLog(state.errorTitle, state.errorMessage);
        //       }
        //     },
        //     child: BlocBuilder<RegisterBloc, RegisterState>(
        //         builder: (context, state) {
        //       return Container(
        //         padding: EdgeInsets.fromLTRB(30, 100, 30, 10),
        //         color: Colors.white30,
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.start,
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: <Widget>[
        //             Container(
        //               padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
        //               child: Text(
        //                 'Đăng ký thành viên',
        //                 textAlign: TextAlign.center,
        //                 style: TextStyle(
        //                     fontWeight: FontWeight.bold,
        //                     color: Colors.black,
        //                     fontSize: 25),
        //               ),
        //             ),
        //             Container(
        //               padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
        //               child: TextField(
        //                 controller: _user,
        //                 style: TextStyle(fontSize: 18, color: Colors.black),
        //                 decoration: InputDecoration(
        //                     labelText: 'Tài khoản',
        //                     labelStyle: TextStyle(
        //                         color: Color(0xffd888888), fontSize: 15)),
        //               ),
        //             ),
        //             Container(
        //               padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
        //               child: TextField(
        //                 controller: _pass,
        //                 obscureText: true,
        //                 style: TextStyle(fontSize: 18, color: Colors.black),
        //                 decoration: InputDecoration(
        //                     labelText: 'Mật khẩu',
        //                     labelStyle: TextStyle(
        //                         color: Color(0xffd888888), fontSize: 15)),
        //               ),
        //             ),
        //             Container(
        //               padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
        //               child: TextField(
        //                 controller: _name,
        //                 style: TextStyle(fontSize: 18, color: Colors.black),
        //                 decoration: InputDecoration(
        //                     labelText: 'Họ và tên',
        //                     labelStyle: TextStyle(
        //                         color: Color(0xffd888888), fontSize: 15)),
        //               ),
        //             ),
        //             Padding(
        //               padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
        //               child: SizedBox(
        //                 height: 56,
        //                 width: double.infinity,
        //                 child: RaisedButton(
        //                   onPressed: () {
        //                     BlocProvider.of<RegisterBloc>(context).add(
        //                       OnPressButtonEvent(
        //                           context: context,
        //                           username: _user.text,
        //                           password: _pass.text,
        //                           name: _name.text,
        //                           registerStream: registerStream),
        //                     );
        //                   },
        //                   color: Colors.blueAccent,
        //                   shape: RoundedRectangleBorder(
        //                     borderRadius: BorderRadius.all(Radius.circular(10)),
        //                   ),
        //                   child: Text(
        //                     'Sign In',
        //                     style: TextStyle(color: Colors.white, fontSize: 16),
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //       );
        //     }),
        //   ),
        // ),
      ),
    );
  }

  Widget diaLog(String title, String message) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(message),
    );
  }
}
