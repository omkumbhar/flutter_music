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
                listItem("MARATHI", "images/marathi.jpg",
                    size: MediaQuery.of(context).size.width * 0.4379),
                voidCallback: () {
                  widget.callback(["marathi", ""]);
                },
              ),
              _listTile(
                listItem("HINDI", "images/hindi2.jpg",
                    size: MediaQuery.of(context).size.width * 0.4379),
                voidCallback: () {
                  widget.callback(["hindi", ""]);
                },
              ),
              _listTile(
                  listItem("ENGLISH", "images/english.jpg",
                      size: MediaQuery.of(context).size.width * 0.4379),
                  voidCallback: () {
                widget.callback(["english", ""]);
              }),
              _listTile(
                listItem("GLOBAL HITS", "images/playing.JPG",
                    size: MediaQuery.of(context).size.width * 0.4379),
                voidCallback: () {
                  widget.callback(["global_hits", ""]);
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
