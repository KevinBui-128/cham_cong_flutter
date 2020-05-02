import 'package:chamcongapp/blocs/update_employees_bloc/update_employees_bloc.dart';
import 'package:chamcongapp/data/model/employeesModel.dart';
import 'package:chamcongapp/streams/updateEmployeesStream.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateEmployeesPage extends StatefulWidget {
  final Employee employee;

  UpdateEmployeesPage({Key key, @required this.employee}) : super(key: key);

  @override
  _UpdateEmployeesPageState createState() => _UpdateEmployeesPageState();
}

class _UpdateEmployeesPageState extends State<UpdateEmployeesPage> {
  TextEditingController _name = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _phone = TextEditingController();
  UpdateEmployeesStream updateEmployeesStream;

  @override
  void initState() {
    updateEmployeesStream = UpdateEmployeesStream();
    _name.text = widget.employee.name;
    _address.text = widget.employee.address;
    _phone.text = (widget.employee.phone).toString();
    super.initState();
  }

  @override
  void dispose() {
    updateEmployeesStream.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cập nhật thông tin nhân viên'),
      ),
      body: SingleChildScrollView(
        child: BlocProvider(
          builder: (context) => UpdateEmployeesBloc(),
          child: BlocListener<UpdateEmployeesBloc, UpdateEmployeesState>(
            listener: (context, state) {
              if (state is ErrorState) {
                _showDialog(context, state.errorTitle, state.errorMessage);
              } else if (state is LoadingState) {
                _loadingData(context);
              } else if (state is UpdateSuccessState) {
                _showDialog(context, state.title, state.message);
              }
            },
            child: BlocBuilder<UpdateEmployeesBloc, UpdateEmployeesState>(
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
                        'Tài khoản \n${widget.employee.username}',
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
                        stream: updateEmployeesStream.nameStream,
                        builder: (context, snapshot) => TextField(
                          controller: _name,
                          // textInputAction: TextInputAction.next,
                          onChanged: (va) {
                            updateEmployeesStream.nameChange(va);
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
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                      child: StreamBuilder(
                        stream: updateEmployeesStream.addressStream,
                        builder: (context, snapshot) => TextField(
                          controller: _address,
                          // textInputAction: TextInputAction.next,
                          onChanged: (va) {
                            updateEmployeesStream.addressChange(va);
                          },
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          decoration: InputDecoration(
                              labelText: 'Địa chỉ',
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
                        stream: updateEmployeesStream.phoneStream,
                        builder: (context, snapshot) => TextField(
                          controller: _phone,
                          keyboardType: TextInputType.phone,
                          // textInputAction: TextInputAction.next,
                          // onChanged: (va) {
                          //   updateEmployeesStream.phoneChange(va);
                          // },
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          decoration: InputDecoration(
                              labelText: 'Số điện thoại',
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
                            BlocProvider.of<UpdateEmployeesBloc>(context).add(
                              OnPressUpdateEvent(
                                  context: context,
                                  username: widget.employee.username,
                                  password: widget.employee.password,
                                  name: _name.text,
                                  address: _address.text,
                                  phone: int.parse(_phone.text),
                                  updateEmployeesStream: updateEmployeesStream),
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

  Widget _loadingData(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  _showDialog(BuildContext mainContext, String title, String message) async {
    await showDialog(
      context: mainContext,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text("Ok"),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
