import 'package:flutter/material.dart';

import 'list_tile.dart';

// ignore: must_be_immutable
class OnlineHome extends StatefulWidget {
  Function callback;
  OnlineHome({this.callback});
  @override
  _OnlineHomeState createState() => _OnlineHomeState();
}

class _OnlineHomeState extends State<OnlineHome> {
  Widget _listTile(Widget widget, {VoidCallback voidCallback}) {
    return GestureDetector(
      child: widget,
      onTap: voidCallback ??
          () {
            print("Default function");
          },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
              /*height: 40.0,
              width: double.infinity,*/
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
              child: Text(
                "Collections",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 23.0),
              )),
          Wrap(
            children: [
              _listTile(
                listItem("Marathi", "images/marathi.jpg", colors: [
                  Colors.yellow.shade400.withOpacity(0.6),
                  Colors.deepOrange.shade400.withOpacity(0.6)
                ]),
                voidCallback: () {
                  widget.callback("marathi");
                },
              ),
              _listTile(
                listItem("Hindi", "images/hindi2.jpg", colors: [
                  Colors.pink.withOpacity(0.6),
                  Colors.pinkAccent.withOpacity(0.7)
                ]),
                voidCallback: () {
                  widget.callback("hindi");
                },
              ),
              _listTile(
                  listItem("English", "images/english.jpg", colors: [
                    Color(0xff175a9d).withOpacity(0.6),
                    Color(0xff56bf9c).withOpacity(0.6)
                  ]), voidCallback: () {
                widget.callback("english");
              }),
              _listTile(
                listItem("Global hits", "images/music_Logo.jpg"),
                voidCallback: () {
                  widget.callback("global_hits");
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
