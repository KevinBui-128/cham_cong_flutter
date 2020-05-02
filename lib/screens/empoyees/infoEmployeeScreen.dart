import 'package:chamcongapp/blocs/update_employees_bloc/update_employees_bloc.dart';
import 'package:chamcongapp/configs/config.dart';
import 'package:chamcongapp/data/model/employeesModel.dart';
import 'package:chamcongapp/screens/empoyees/updateEmployeesScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class InfoEmployeePage extends StatefulWidget {
  final Employee employee;

  InfoEmployeePage({Key key, @required this.employee}) : super(key: key);

  @override
  _InfoEmployeePageState createState() => _InfoEmployeePageState();
}

class _InfoEmployeePageState extends State<InfoEmployeePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thông tin nhân viên"),
      ),
      floatingActionButton: SpeedDial(
        curve: Curves.easeOutExpo,
        animatedIcon: AnimatedIcons.menu_close,
        overlayColor: Colors.white70,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white70,
        animatedIconTheme: IconThemeData.fallback(),
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
              child: Icon(
                Icons.edit,
                color: Colors.white70,
              ),
              label: "Sửa",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateEmployeesPage(
                      employee: widget.employee,
                    ),
                  ),
                );
              },
              backgroundColor: Colors.lightBlue),
          SpeedDialChild(
              child: Icon(
                Icons.delete,
                color: Colors.white70,
              ),
              backgroundColor: Colors.redAccent,
              label: "Xóa",
              onTap: () {
                _showDelDialog(context, widget.employee.username);
              }),
        ],
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
                  child: Icon(
                    Icons.person_pin,
                    size: 150,
                  )),
              Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                  child: Text(widget.employee.username,
                      style: TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold))),
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Họ và tên: "),
                    Text(widget.employee.name),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Địa chỉ: "),
                    Text(widget.employee.address),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Số điện thoại: "),
                    Text((widget.employee.phone).toString()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showDelDialog(BuildContext mainContext, String username) async {
    await showDialog(
      context: mainContext,
      builder: (context) => BlocProvider(
        builder: (context) => UpdateEmployeesBloc(),
        child: BlocListener<UpdateEmployeesBloc, UpdateEmployeesState>(
          listener: (context, state) {
            if (state is ErrorState) {
              _showDialog(context, state.errorTitle, state.errorMessage);
            } else if (state is DelSuccessState) {
              _showDialog(context, state.title, state.message);
            }
          },
          child: BlocBuilder<UpdateEmployeesBloc, UpdateEmployeesState>(
            builder: (context, state) {
              return AlertDialog(
                title: Text("Bạn thực sự muốn xóa?"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Xóa"),
                    onPressed: () {
                      ConfigsApp.userName == username
                          ? _showDialog(context, "Thông báo",
                              "Bạn không thể xóa chính bạn")
                          : BlocProvider.of<UpdateEmployeesBloc>(context).add(
                              DelButtonEmployeesEvent(
                                username: username,
                                context: context,
                              ),
                            );
                      print("xóa thành công");
                    },
                  ),
                  FlatButton(
                    child: Text("Hủy"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            },
          ),
        ),
      ),
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
