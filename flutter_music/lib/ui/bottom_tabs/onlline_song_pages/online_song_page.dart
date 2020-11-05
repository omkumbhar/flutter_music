import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music/constants.dart';
import 'package:flutter_music/model/online_song.dart';
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
  List<Color> colors = [
    Colors.teal[600],
    Colors.green[600],
    Colors.lime[600],
    Colors.amber[600],
    Colors.deepOrange[600],
    Colors.cyan[600]
  ];

  Stream<QuerySnapshot> getSongs() async* {
    await for (var song in FirebaseFirestore.instance
        .collection('songs')
        .where('song_language', isEqualTo: widget.songType ?? 'marathi')
        //.orderBy('artist_name')
        //.orderBy('song_name')
        .snapshots()) {
      yield song;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: getSongs(),
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
          return ListView.builder(
            itemCount: onlineSongList.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.blueGrey.withOpacity(0.6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  selected: index == _selectedIndex,
                  onTap: () {
                    onlineSongPlayer.play(index);
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  leading: null == null
                      ? CircleAvatar(
                          backgroundColor: colors[index % colors.length],
                          child: Icon(Icons.audiotrack_rounded),
                          radius: 20.0,
                        )
                      : null,
                  title: Text(
                    onlineSongList[index].songName,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 15.0),
                  ),
                  dense: true,
                ),
              );
            },
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
