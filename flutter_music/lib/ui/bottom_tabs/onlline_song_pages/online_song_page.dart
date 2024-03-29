import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music/constants.dart';
import 'package:flutter_music/model/online_song.dart';
import 'package:flutter_music/online_songs/online_query.dart';
import 'package:flutter_music/ui/song_list_widgets/song_list_view.dart';
import 'package:loading_animations/loading_animations.dart';

// ignore: must_be_immutable
class OnlineSongList extends StatefulWidget {
  String songType;

  OnlineSongList({this.songType});

  @override
  _OnlineSongListState createState() => _OnlineSongListState();
}

class _OnlineSongListState extends State<OnlineSongList> {
  List<OnlineSong> onlineSongList = [];
  int _selectedIndex;

  void callBack(int index) {
    if (isLocalPlayed) isLocalPlayed = false;
    onlineSongPlayer.play(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseQuery firebaseQuery = FirebaseQuery();
    return StreamBuilder(
      stream: firebaseQuery.getSongs(songType: widget.songType),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          List<QueryDocumentSnapshot> songs = snapshot.data.docs;
          onlineSongList = List.generate(
            snapshot.data.docs.length,
            (index) => OnlineSong(
                artistName: songs[index].get("artist_name"),
                imageUrl: songs[index].get("image_url"),
                songLanguage: songs[index].get("song_language"),
                songName: songs[index].get("song_name"),
                songUrl: songs[index].get("song_url")),
          );
          onlineSongPlayer.songsList = onlineSongList; // give list to player
          return Container(
            child: Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: ListView.builder(
                itemCount: onlineSongList.length,
                itemBuilder: (context, index) {
                  return onlineSongListTile(
                      songName: onlineSongList[index].songName,
                      index: index,
                      isSelected: index == _selectedIndex,
                      callback: callBack);
                },
              ),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: LoadingBouncingGrid.circle(
              size: 100.0,
            ),
          );
        } else if (!snapshot.hasData) {
          return Center(
            child: Text(
              "No song",
              style: TextStyle(color: Colors.white),
            ),
          );
        }
        return Text(
          "No song",
          style: TextStyle(color: Colors.white),
        );
      },
    );
  }
}
