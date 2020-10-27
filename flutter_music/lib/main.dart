import 'package:flutter/material.dart';
import 'ui/home.dart';

void main() {
  runApp(MyAppp());
}

class MyAppp extends StatefulWidget {
  @override
  _MyApppState createState() => _MyApppState();
}

class _MyApppState extends State<MyAppp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BottomBar(),
    );
  }
}


// https://pub.dev/packages/bottom_personalized_dot_bar/install
  // https://pub.dev/packages/animations