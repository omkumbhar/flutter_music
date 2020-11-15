import 'package:flutter/material.dart';
import 'package:flutter_music/constants.dart';

List<Color> colors = [
  /*Colors.teal[600],
  Colors.green[600],
  Colors.lime[600],
  Colors.amber[600],
  Colors.deepOrange[600],
  Colors.cyan[600]*/
  TEXT_COLOR_WHITE
];

Card songListTile(
    {String songName, int index, bool isSelected, Function callback}) {
  return Card(
    color: TEXT_COLOR_WHITE.withOpacity(0.6),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: ListTile(
      selected: isSelected,
      onTap: () {
        callback(index);
      },
      leading: null == null
          ? CircleAvatar(
              backgroundColor: YELLOW.withOpacity(1) /*Colors.blueAccent*/,
              child: Icon(
                Icons.audiotrack_rounded,
                color: PINK,
              ),
              radius: 20.0,
            )
          : null,
      title: Text(
        songName,
        style: TextStyle(
            color: VIOLET, fontWeight: FontWeight.w500, fontSize: 15.0),
      ),
      dense: true,
    ),
  );
}

Card onlineSongListTile(
    {String songName, int index, bool isSelected, Function callback}) {
  return Card(
    color: TEXT_COLOR_WHITE.withOpacity(0.6),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: ListTile(
      selected: isSelected,
      onTap: () {
        callback(index);
      },
      leading: null == null
          ? CircleAvatar(
              backgroundColor: YELLOW.withOpacity(1) /*Colors.blueAccent*/,
              child: Icon(
                Icons.audiotrack_rounded,
                color: PINK,
              ),
              radius: 20.0,
            )
          : null,
      title: Text(
        songName,
        style: TextStyle(
            color: VIOLET, fontWeight: FontWeight.w500, fontSize: 15.0),
      ),
      dense: true,
    ),
  );
}
