import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Đăng nhập'),),
      body: Center(
        child: Text(
          'Đăng nhập thành công rồi nè',
          style: TextStyle(
              fontSize: 20, color: Colors.blueGrey, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
