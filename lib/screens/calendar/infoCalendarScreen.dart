import 'package:flutter/material.dart';

class InfoCalendarPage extends StatefulWidget {
  @override
  _InfoCalendarPageState createState() => _InfoCalendarPageState();
}

class _InfoCalendarPageState extends State<InfoCalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {},
            enableFeedback: false,
          )
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
                    Icons.event_note,
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
                padding: EdgeInsets.fromLTRB(0, 0, 0, 35),
                child: TextField(
                  // focusNode: _passWord,
                  // controller: _pass,
                  onChanged: (va) {
                    // loginStream.passwordChange(va);
                  },
                  keyboardType: TextInputType.multiline,
                  minLines: 3,
                  maxLines: null,

                  // obscureText: true,
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  decoration: InputDecoration(
                      labelText: 'Nội dung',
                      // errorText:
                      // snapshot.hasError ? snapshot.error : null,
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
}
