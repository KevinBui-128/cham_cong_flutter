import 'package:chamcongapp/data/model/employeesModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class InfoEmployeePage extends StatefulWidget {
  final Employee employee;

  InfoEmployeePage({@required this.employee});

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
              onTap: () {},
              backgroundColor: Colors.lightBlue),
          SpeedDialChild(
              child: Icon(
                Icons.delete,
                color: Colors.white70,
              ),
              backgroundColor: Colors.redAccent,
              label: "Xóa",
              onTap: () {}),
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
                    Icons.people,
                    size: 150,
                  )),
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                child: TextField(
                  // focusNode: _userName,
                  onSubmitted: (va) {
                    // _fieldFocusChange(context, _userName, _passWord);
                  },
                  // controller: _user,
                  onChanged: (va) {
                    // loginStream.usernameChange(va);
                  },
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  decoration: InputDecoration(
                      labelText: 'Tiêu đề',
                      // errorText:
                      //     snapshot.hasError ? snapshot.error : null,
                      labelStyle:
                          TextStyle(color: Color(0xffd888888), fontSize: 15)),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                child: TextField(
                  // focusNode: _userName,
                  onSubmitted: (va) {
                    // _fieldFocusChange(context, _userName, _passWord);
                  },
                  // controller: _user,
                  onChanged: (va) {
                    // loginStream.usernameChange(va);
                  },
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  decoration: InputDecoration(
                      labelText: 'Tiêu đề',
                      // errorText:
                      //     snapshot.hasError ? snapshot.error : null,
                      labelStyle:
                          TextStyle(color: Color(0xffd888888), fontSize: 15)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // _showDelDialog(BuildContext mainContext, String username) async {
  //   await showDialog(
  //     context: mainContext,
  //     builder: (context) => AlertDialog(
  //       title: Text("Bạn thực sự muốn xóa?"),
  //       actions: <Widget>[
  //         FlatButton(
  //           child: Text("Xóa"),
  //           onPressed: () {
  //             BlocProvider.of<EmployeesBloc>(mainContext).add(
  //               DelButtonEmployeesEvent(
  //                 name: "null",
  //                 password: "null",
  //                 username: username,
  //               ),
  //             );
  //             print("xóa thành công");
  //             Navigator.pop(context);
  //           },
  //         ),
  //         FlatButton(
  //           child: Text("Hủy"),
  //           onPressed: () {
  //             Navigator.pop(context);
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
