import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'ui/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
//https://stackoverflow.com/questions/49648022/check-whether-there-is-an-internet-connection-available-on-flutter-app
