import 'package:flutter/material.dart';
import 'package:flutter_music/constants.dart';
import 'package:flutter_music/firebase_auth/firebase_auth_handler.dart';
import 'package:flutter_music/firebase_auth/setup_user.dart';

class AuthPage extends StatelessWidget {
  final Function fun;
  AuthPage(this.fun);

  void signIn() {
    signInWithGoogle().then((user) {
      createDoc(user);
      firebaseUser = user;
      fun(user);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/startImage.jpg"),
                    fit: BoxFit.cover)),
          ),
          Container(
            color: Colors.black12.withOpacity(0.6),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Spacer(
                  flex: 2,
                ),
                Text(
                  "My Music",
                  style: TextStyle(
                      fontSize: 50.0,
                      color: Colors.white,
                      fontStyle: FontStyle.italic),
                ),
                Spacer(
                  flex: 4,
                ),
                ElevatedButton(
                  onPressed: signIn,
                  style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all<Color>(
                          Colors.grey.withOpacity(0.6)),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      shadowColor: MaterialStateProperty.all<Color>(
                          Colors.white.withOpacity(0.5)),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.all(5.0))),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        child: Image(
                          image: AssetImage("images/google_logo.png"),
                          height: 25.0,
                          width: 25.0,
                        ),
                        padding: EdgeInsets.only(right: 5.0),
                      ),
                      Text(
                        "Login using Google",
                        style: TextStyle(
                            color: Colors.lightBlue,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      )
                    ],
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
