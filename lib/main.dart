import 'package:chamcongapp/screens/homeScreen.dart';
import 'package:chamcongapp/screens/loginScreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}