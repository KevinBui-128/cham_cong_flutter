import 'dart:convert';

import 'package:chamcongapp/blocs/calendar_bloc/calendar_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  TextEditingController _eventController;
  SharedPreferences prefs;

  final _calendarBloc = CalendarBloc();
  GlobalKey calendarGlobalKey = GlobalKey();
  int _specialDay;
  int _workDay;
  int _dayOff;

  @override
  void dispose() {
    _calendarBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _eventController = TextEditingController();
    _events = {};
    _selectedEvents = [];
    initPrefs();
  }

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _events = Map<DateTime, List<dynamic>>.from(
          decodeMap(json.decode(prefs.getString("events") ?? "{}")));
    });
  }

  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (BuildContext context) =>
          _calendarBloc..add(LoadCalendarEvent()),
      child: BlocListener<CalendarBloc, CalendarState>(
        listener: (context, state) {
          if (state is ErrorState) {
            BlocProvider.of<CalendarBloc>(context).add(
              LoadCalendarEvent(),
            );
            return _showDialog(context, state.errorTitle, state.errorMessage);
          } else if (state is SuccessState) {
            BlocProvider.of<CalendarBloc>(context).add(
              LoadCalendarEvent(),
            );
            return _showDialog(context, state.title, state.message);
          }
        },
        child: BlocBuilder<CalendarBloc, CalendarState>(
          builder: (BuildContext context, CalendarState state) {
            if (state is LoadingState) {
              return _loadingData(context);
            } else if (state is LoadedState) {
              return Scaffold(
                key: calendarGlobalKey,
                body: SafeArea(
                  top: true,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Card(
                          child: TableCalendar(
                            // locale: "en_US",
                            events: _events,
                            initialCalendarFormat: CalendarFormat.month,
                            calendarStyle: CalendarStyle(
                              canEventMarkersOverflow: true,
                              todayColor: Colors.orange,
                              // holidayStyle: TextStyle(color: Colors.red),
                              selectedColor: Theme.of(context).primaryColor,
                              todayStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  color: Colors.white),
                            ),
                            headerStyle: HeaderStyle(
                              centerHeaderTitle: true,
                              formatButtonDecoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              formatButtonTextStyle:
                                  TextStyle(color: Colors.white),
                              formatButtonShowsNext: false,
                            ),
                            startingDayOfWeek: StartingDayOfWeek.monday,
                            onDaySelected: (date, events) {
                              setState(
                                () {
                                  _selectedEvents = events;
                                },
                              );
                            },
                            builders: CalendarBuilders(
                              selectedDayBuilder: (context, date, events) =>
                                  Container(
                                margin: const EdgeInsets.all(4.0),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text(
                                  date.day.toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              // holidayDayBuilder: (context, date, events) =>
                              //     Container(
                              //   margin: const EdgeInsets.all(4.0),
                              //   alignment: Alignment.center,
                              //   decoration: BoxDecoration(
                              //     color: Colors.redAccent,
                              //     borderRadius: BorderRadius.circular(10.0),
                              //   ),
                              //   child: Text(
                              //     date.day.toString(),
                              //     style: TextStyle(color: Colors.white),
                              //   ),
                              // ),
                              todayDayBuilder: (context, date, events) =>
                                  Container(
                                margin: const EdgeInsets.all(4.0),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text(
                                  date.day.toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            calendarController: _controller,
                          ),
                        ),
                        ..._selectedEvents.map(
                          (event) => Card(
                            child: ListTile(
                              leading: Icon(Icons.event),
                              title: Text(event),
                              subtitle: Text(event),
                              trailing: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  _showDelDialog(event);
                                },
                              ),
                              onTap: () {
                                print("object");
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => InfoCalendarPage()));
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: () {
                    _showAddDialog();
                  },
                ),
              );
            } else {
              return _buildEmptyBody();
            }
          },
        ),
      ),
    );
  }

  Widget _buildEmptyBody() {
    return Center(
      child: const Text("</ Bạn chưa check in />"),
    );
  }

  _showDelDialog(event) async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Bạn thực sự muốn xóa?"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Xóa"),
                  onPressed: () {
                    _selectedEvents.remove(event);
                    // BlocProvider.of<CalendarBloc>(
                    //         calendarGlobalKey.currentContext)
                    //     .add(
                    //   DelButtonCalendarEvent(
                    //       context: calendarGlobalKey.currentContext,
                    //       workDay: _workDay,
                    //       dayOff: _dayOff,
                    //       specialDay: _specialDay),
                    // );
                    prefs.setString(
                      "events",
                      json.encode(
                        encodeMap(_events),
                      ),
                    );
                    print("xóa thành công");
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text("Hủy"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ));
    setState(
      () {
        _selectedEvents = _events[_controller.selectedDay];
      },
    );
  }
  // _showAddDialog() async {
  //   await showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //             title: Text("Thêm sự kiện"),
  //             content: TextField(
  //               controller: _eventController,
  //             ),
  //             actions: <Widget>[
  //               FlatButton(
  //                 child: Text("Save"),
  //                 onPressed: () {
  //                   if (_eventController.text.isEmpty) return;
  //                   setState(() {
  //                     if (_events[_controller.selectedDay] != null) {
  //                       _events[_controller.selectedDay]
  //                           .add(_eventController.text);
  //                     } else {
  //                       _events[_controller.selectedDay] = [
  //                         _eventController.text
  //                       ];
  //                     }
  //                     prefs.setString(
  //                       "events",
  //                       json.encode(
  //                         encodeMap(_events),
  //                       ),
  //                     );
  //                     _eventController.clear();
  //                     Navigator.pop(context);
  //                   });
  //                 },
  //               ),
  //               FlatButton(
  //                   onPressed: () {
  //                     Navigator.pop(context);
  //                   },
  //                   child: Text("Không lưu"))
  //             ],
  //           ));
  //   setState(
  //     () {
  //       _selectedEvents = _events[_controller.selectedDay];
  //     },
  //   );
  // }

  // void _addCheckin() {
  //   // var checkinDate = DateTime.now().millisecondsSinceEpoch;
  //   // var checkinDate2 = DateTime.now();
  //   // var checkinDateTest = DateTime.utc(2020, 4, 12);
  //   // var ketqua = dayTimeFormat
  //   //     .format(new DateTime.fromMillisecondsSinceEpoch(checkinDate));
  //   // var ketqua2 = df.format(
  //   //     new DateTime.fromMillisecondsSinceEpoch(1586625611662));

  //   final birthday = DateTime(2020, 4, 10).millisecondsSinceEpoch;
  //   // final date2 = DateTime.now();
  //   // final difference = date2.difference(checkinDate).inHours;
  //   // print(birthday);
  //   // print(difference);
  //   // print(date2);
  //   print(birthday);
  //   // print(ketqua);
  //   // print(ketqua - ketqua2);
  // }

  _showAddDialog() async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Thêm sự kiện"),
              content: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: RaisedButton(
                      color: Colors.yellow,
                      onPressed: () {
                        setState(() {
                          _eventController.text = "Ngày nghỉ";
                          _specialDay = null;
                          _workDay = null;
                          _dayOff =
                              _controller.selectedDay.millisecondsSinceEpoch;
                        });
                      },
                      child: Text("Ngày nghỉ"),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: RaisedButton(
                      color: Colors.greenAccent,
                      onPressed: () {
                        setState(() {
                          _eventController.text = "Ngày đi làm";
                          _specialDay = null;
                          _workDay =
                              _controller.selectedDay.millisecondsSinceEpoch;
                          _dayOff = null;
                        });
                      },
                      child: Text("Ngày đi làm"),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: RaisedButton(
                      color: Colors.redAccent,
                      onPressed: () {
                        setState(() {
                          _eventController.text = "Ngày nghỉ lễ";
                          _specialDay =
                              _controller.selectedDay.millisecondsSinceEpoch;
                          _workDay = null;
                          _dayOff = null;
                        });
                      },
                      child: Text("Ngày nghỉ lễ"),
                    ),
                  ),
                  TextField(
                    enabled: false,
                    controller: _eventController,
                  )
                ],
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("Save"),
                  onPressed: () {
                    setState(() {
                      if (_events[_controller.selectedDay] != null) {
                        _events[_controller.selectedDay]
                            .add(_eventController.text);

                        // BlocProvider.of<CalendarBloc>(
                        //         calendarGlobalKey.currentContext)
                        //     .add(
                        //   OnPressUpdateEvent(
                        //       context: calendarGlobalKey.currentContext,
                        //       workDay: _workDay,
                        //       dayOff: _dayOff,
                        //       specialDay: _specialDay),
                        // );
                      } else {
                        _events[_controller.selectedDay] = [
                          _eventController.text
                        ];
                        // BlocProvider.of<CalendarBloc>(
                        //         calendarGlobalKey.currentContext)
                        //     .add(
                        //   OnPressButtonEvent(
                        //       context: calendarGlobalKey.currentContext,
                        //       workDay: _workDay,
                        //       dayOff: _dayOff,
                        //       specialDay: _specialDay),
                        // );
                      }
                      prefs.setString(
                        "events",
                        json.encode(
                          encodeMap(_events),
                        ),
                      );
                      print(_controller.selectedDay);
                      print(_controller.selectedDay.millisecondsSinceEpoch);
                      print(DateTime.now());
                      print(DateTime.now().millisecondsSinceEpoch);
                      _eventController.clear();
                      Navigator.pop(context, true);
                    });
                  },
                ),
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: Text("Không lưu"))
              ],
            )).then((onValue) {
      if (onValue ?? false) {
        setState(
          () {
            _selectedEvents = _events[_controller.selectedDay];
          },
        );
      }
    });
  }

  // Widget _buildPopupMenu() {
  //   String event = "";
  //   return PopupMenuButton<int>(
  //     onSelected: (int result) {
  //       if (result == 1) {
  //         event = "workDay";
  //       } else if (result == 2) {
  //         event = "dayOff";
  //       } else {
  //         event = "specialDay";
  //       }
  //     },
  //     itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
  //       const PopupMenuItem<int>(
  //         value: 1,
  //         child: Text('Ngày đi làm'),
  //       ),
  //       const PopupMenuItem<int>(
  //         value: 2,
  //         child: Text('Ngày nghỉ'),
  //       ),
  //       const PopupMenuItem<int>(
  //         value: 3,
  //         child: Text('Ngày lễ'),
  //       ),
  //     ],
  //   );
  // }

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

  Widget _loadingData(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  // Widget _buildEmptyBody() {
  //   return Center(
  //     child: const Text("</ lịch  />"),
  //   );
  // }
}
