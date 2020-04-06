import 'package:chamcongapp/screens/calendarScreen.dart';
import 'package:chamcongapp/screens/checkinScreen.dart';
import 'package:chamcongapp/screens/employeesScreen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> containers = [
    Container(
      child: CalendarPage(),
    ),
    Container(
      child: EmployeesPage(),
    ),
    Container(
      child: CheckinPage(),
    )
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: 'Lịch làm việc'),
              Tab(text: 'Ds nhân viên'),
              Tab(text: 'Check in')
            ],
          ),
        ),
        body: TabBarView(children: containers),
      ),
    );
  }
}
