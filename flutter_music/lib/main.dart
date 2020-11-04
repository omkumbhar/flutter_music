import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music/ui/Upload.dart';
import 'package:provider/provider.dart';
import './provider/auth.dart';
import 'ui/auth_screen.dart';
import 'ui/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyAppp());
}

class MyAppp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider.value(
          value:Auth()
          ),
      ],
      
    child:Consumer<Auth>(builder: (ctx, auth, _)=>MaterialApp(
      title: 'MyShop',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.deepOrange,
        fontFamily: 'Lato',
      ),
      //home: BottomBar(),
      home: auth.isAuth ?BottomBar():  AuthScreen(),
    routes: {
      Upload.routeName :(ctx) => Upload()
    },

    ),
    )
    );
  }
}



// https://pub.dev/packages/bottom_personalized_dot_bar/install
// https://pub.dev/packages/animations
//https://stackoverflow.com/questions/49648022/check-whether-there-is-an-internet-connection-available-on-flutter-app
