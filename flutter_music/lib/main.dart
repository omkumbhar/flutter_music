import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'ui/auth_screen/auth_screen.dart';
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
  User user = auth.currentUser;

  void callHomePage(User user) {
    setState(() {
      this.user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(builder: (context) {
        if (user == null) {
          return AuthPage(callHomePage); /*BottomBar();*/
        } else {
          firebaseUser = user;
          return BottomBar();
        }
      }),
    );
  }
}

// https://pub.dev/packages/bottom_personalized_dot_bar/install
// https://pub.dev/packages/animations
//https://stackoverflow.com/questions/49648022/check-whether-there-is-an-internet-connection-available-on-flutter-app
