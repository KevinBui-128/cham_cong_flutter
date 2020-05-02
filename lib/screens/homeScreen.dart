import 'package:chamcongapp/screens/calendar/calendarScreen.dart';
import 'package:chamcongapp/screens/checkin/checkinScreen.dart';
import 'package:chamcongapp/screens/empoyees/employeesScreen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;
  final _indexObject = [
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

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Thông báo'),
            content: Text('Bạn muốn thoát app chứ?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Không'),
              ),
              FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Có'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          
          body: _indexObject[_index],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _index,
            onTap: (int index) {
              setState(() {
                _index = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                  title: Text('Lịch'), icon: Icon(Icons.calendar_today)),
              BottomNavigationBarItem(
                  title: Text('Nhân viên'), icon: Icon(Icons.person)),
              BottomNavigationBarItem(
                  title: Text('Check in'), icon: Icon(Icons.compare_arrows)),
            ],
          ),
          // TabBarView(children: containers),
        ),
      ),
    );
  }
}
