import 'package:chamcongapp/blocs/checkin_bloc/checkin_bloc.dart';
import 'package:chamcongapp/configs/config.dart';
import 'package:chamcongapp/data/model/checkinModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';

class CheckinPage extends StatefulWidget {
  @override
  _CheckinPageState createState() => _CheckinPageState();
}

class _CheckinPageState extends State<CheckinPage> {
  final dayTimeFormat = new DateFormat('dd-MM-yyyy hh:mm:ss');
  final dayFormat = new DateFormat('dd-MM-yyyy');
  final timeFormat = new DateFormat('hh:mm:ss a');

  final dayNow = DateTime.now().millisecondsSinceEpoch;

  final _checkinBloc = CheckinBloc();

  GlobalKey checkinGlobalKey = GlobalKey();

  @override
  void dispose() {
    _checkinBloc.close();
    super.dispose();
  }

  void formatDay(day, value) {
    day.format(new DateTime.fromMillisecondsSinceEpoch(value));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (BuildContext context) => _checkinBloc..add(LoadCheckinEvent()),
      child: BlocListener<CheckinBloc, CheckinState>(
        listener: (context, state) {
          if (state is ErrorState) {
            BlocProvider.of<CheckinBloc>(context).add(
              LoadCheckinEvent(),
            );
            return _showDialog(context, state.errorTitle, state.errorMessage);
          } else if (state is SuccessState) {
            BlocProvider.of<CheckinBloc>(context).add(
              LoadCheckinEvent(),
            );
            return _showDialog(context, state.title, state.message);
          }
        },
        child: BlocBuilder<CheckinBloc, CheckinState>(
          builder: (BuildContext context, CheckinState state) {
            if (state is LoadingState) {
              return _loadingData(context);
            } else if (state is LoadedState) {
              return Scaffold(
                  key: checkinGlobalKey,
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
                            Icons.exit_to_app,
                            color: Colors.white70,
                          ),
                          label: "Check out",
                          onTap: () {
                            BlocProvider.of<CheckinBloc>(
                                    checkinGlobalKey.currentContext)
                                .add(
                              OnPressCheckoutEvent(
                                context: checkinGlobalKey.currentContext,
                                checkoutTime: dayNow,
                                workTime: DateTime.now()
                                    .difference(ConfigsApp.checkinFormat)
                                    .inHours,
                              ),
                            );
                          },
                          backgroundColor: Colors.redAccent),
                      SpeedDialChild(
                          child: Icon(
                            Icons.open_in_browser,
                            color: Colors.white70,
                          ),
                          backgroundColor: Colors.lightBlue,
                          label: "Check in",
                          onTap: () async {
                            _tapCheckin();
                          }),
                    ],
                  ),
                  body: _buildList(context, state.checkinList));
            } else {
              return _buildEmptyBody();
            }
          },
        ),
      ),
    );
  }

  void _tapCheckin() {
    ConfigsApp.checkinFormat != null
        ? DateTime.now().difference(ConfigsApp.checkinFormat).inHours == 0
            ? _showDialog(context, "Thông báo", "Bạn đã check in rồi")
            : BlocProvider.of<CheckinBloc>(checkinGlobalKey.currentContext).add(
                OnPressCheckinEvent(
                  context: checkinGlobalKey.currentContext,
                  checkinDate: dayNow,
                  checkinTime: dayNow,
                ),
              )
        : BlocProvider.of<CheckinBloc>(checkinGlobalKey.currentContext).add(
            OnPressCheckinEvent(
              context: checkinGlobalKey.currentContext,
              checkinDate: dayNow,
              checkinTime: dayNow,
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

  Widget _loadingData(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildEmptyBody() {
    return Center(
      child: const Text("</ Bạn chưa check in />"),
    );
  }

  Widget _buildList(BuildContext mainContext, List<Datum> checkinList) {
    List<Datum> checkinsList = checkinList;
    return checkinsList.length == 0
        ? Center(
            child: Text("</ Danh sách rỗng />"),
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: checkinsList?.length ?? 0,
            itemBuilder: (context, index) {
              return Card(
                child: Container(
                  width: MediaQuery.of(mainContext).size.width,
                  padding: EdgeInsets.all(10),
                  child: Container(
                    height: MediaQuery.of(mainContext).size.height / 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              "Ngày/Tháng",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(dayFormat.format(
                                new DateTime.fromMillisecondsSinceEpoch(
                                    checkinsList[index]?.checkinDate ?? 128))),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  "Check in: ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(timeFormat.format(
                                    new DateTime.fromMillisecondsSinceEpoch(
                                        checkinsList[index]?.checkinTime ??
                                            128))),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  "Check out: ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(checkinsList[index]?.checkoutTime == 0
                                    ? "chưa checkout"
                                    : timeFormat.format(
                                        new DateTime.fromMillisecondsSinceEpoch(
                                            checkinsList[index]?.checkoutTime ??
                                                128))),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              "Tổng giờ làm",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                                checkinsList[index]?.workTime.toString() ?? 12),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }
}
