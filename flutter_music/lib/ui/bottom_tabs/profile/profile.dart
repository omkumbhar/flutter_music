import 'package:flutter/material.dart';
import 'package:flutter_music/constants.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => new _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [PINK, VIOLET],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)),
          ),
          SafeArea(
            child: Container(
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(firebaseUser.photoURL),
                    /*radius: 75.0,*/
                    minRadius: 50.0,
                    maxRadius: 60.0,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    firebaseUser.displayName,
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    firebaseUser.email,
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment(0.5, 0.72),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: () {
                  /* Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UploadScreen()));*/
                },
                style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all<Color>(
                        Colors.grey.withOpacity(0.6)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shadowColor: MaterialStateProperty.all<Color>(
                        Colors.white.withOpacity(0.5)),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.all(5.0))),
                child: Text(
                  "Logout",
                  style: TextStyle(
                      color: Colors.lightBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(firebaseUser.photoURL),
                /*radius: 75.0,*/
                minRadius: 50.0,
                maxRadius: 60.0,
              )
              /* firebaseUser Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://www.eguardtech.com/wp-content/uploads/2018/08/Network-Profile.png'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.all(Radius.circular(75.0)),
                      boxShadow: [
                        BoxShadow(blurRadius: 7.0, color: Colors.black)
                      ]))*/
              ,
              //SizedBox(height: 90.0),
              Text(
                firebaseUser.displayName,
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat'),
              ),
              //SizedBox(height: 15.0),
              Text(
                '',
                style: TextStyle(
                    fontSize: 17.0,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Montserrat'),
              ),
              //SizedBox(height: 25.0),
              Container(
                  height: 30.0,
                  width: 95.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.redAccent,
                    color: Colors.red,
                    elevation: 7.0,
                    child: GestureDetector(
                      onTap: () {},
                      child: Center(
                        child: Text(
                          'Log out',
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'Montserrat'),
                        ),
                      ),
                    ),
                  ))
            ],
          )
*/
