import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music/constants.dart';
import 'package:flutter_music/model/online_song.dart';
import 'package:flutter_music/online_songs/online_query.dart';
import 'package:flutter_music/ui/song_list_widgets/song_list_view.dart';
import 'package:flutter_music/ui/upload_song_screen/upload_song.dart';
import 'package:loading_animations/loading_animations.dart';

class UploadSong extends StatefulWidget {
  @override
  _UploadSongState createState() => _UploadSongState();
}

class _UploadSongState extends State<UploadSong> {
  final FirebaseQuery firebaseQuery =
      FirebaseQuery(collection: "UsersUpload/uploads/${firebaseUser.uid}");
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StreamBuilder(
            stream: firebaseQuery.getUploadedSongs(),
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
                onlineSongPlayer.songsList =
                    onlineSongList; // give list to player
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: onlineSongList.length,
                  itemBuilder: (context, index) {
                    return onlineSongListTile(
                        songName: onlineSongList[index].songName,
                        index: index,
                        isSelected: index == _selectedIndex,
                        callback: callBack);
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
          ),
          Container(
            width: double.maxFinite,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UploadScreen()));
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
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 5.0),
                    child: Image(
                      image: AssetImage("images/google_logo.png"),
                      height: 25.0,
                      width: 25.0,
                    ),
                  ),
                  Text(
                    "Upload songs",
                    style: TextStyle(
                        color: Colors.lightBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
