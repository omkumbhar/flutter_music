import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class OnlineSongList extends StatefulWidget {
  @override
  _OnlineSongListState createState() => _OnlineSongListState();
}

class _OnlineSongListState extends State<OnlineSongList> {
  List<DocumentSnapshot> _list;
  List<SongInfo> songs = [];
  List<Color> colors = [
    Colors.teal[600],
    Colors.green[600],
    Colors.lime[600],
    Colors.amber[600],
    Colors.deepOrange[600],
    Colors.cyan[600]
  ];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('songs')
          //.where('artist_name', isEqualTo: 'marathi')
          //.orderBy('artist_name')
          .orderBy('song_name')
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.none ||
            !snapshot.hasData) {
          return Text("No song");
        } else if (snapshot.hasData) {
          _list = snapshot.data.docs;

          return ListView.builder(
            itemCount: _list.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.blueGrey.withOpacity(0.6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  /*selected: index == _selectedIndex,*/
                  onTap: () {
                    /*songPlayer.play(index);
                    setState(() {
                      _selectedIndex = index;
                    });*/
                  },
                  leading: null == null
                      ? CircleAvatar(
                          backgroundColor: colors[
                              index % colors.length] /*Colors.blueAccent*/,
                          child: Icon(Icons.audiotrack_rounded),
                          radius: 20.0,
                        )
                      : null,
                  title: Text(
                    _list[index].get("song_url"),
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
        }
        return null;
      },
    );
  }
}
