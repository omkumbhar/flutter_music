import 'package:flutter/material.dart';

Card songListTile(
    {String songName, int index, bool isSelected, Function callback}) {
  List<Color> colors = [
    Colors.teal[600],
    Colors.green[600],
    Colors.lime[600],
    Colors.amber[600],
    Colors.deepOrange[600],
    Colors.cyan[600]
  ];

  return Card(
    color: Colors.blueGrey.withOpacity(0.6),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: ListTile(
      /*selected: index == _selectedIndex,*/
      selected: isSelected,
      onTap: () {
        callback(index);
      },
      leading: null == null
          ? CircleAvatar(
              backgroundColor:
                  colors[index % colors.length] /*Colors.blueAccent*/,
              child: Icon(Icons.audiotrack_rounded),
              radius: 20.0,
            )
          : null,
      title: Text(
        songName,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w300, fontSize: 15.0),
      ),
      dense: true,
    ),
  );
}
