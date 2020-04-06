import 'package:flutter/material.dart';

class CheckinPage extends StatefulWidget {
  @override
  _CheckinPageState createState() => _CheckinPageState();
}

class _CheckinPageState extends State<CheckinPage> {
  List<String> itemList = ["7h30", "8h00", "8h30", "9h00", "9h30", "10h00"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: itemList.length,
        itemBuilder: (context, index) {
          return Card(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.15,
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          "Ngày/Tháng/Năm",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(itemList[index]),
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
                            Text(itemList[index]),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              "Check out: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(itemList[index]),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          "Tổng thời gian",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(itemList[index]),
                      ],
                    ),
                  ],
                )),
          );
        },
      ),
    );
  }
}
