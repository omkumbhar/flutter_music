import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_music/constants.dart';
import 'package:flutter_music/local_songs/audio_query.dart';

class OfflineSongsList extends StatefulWidget {
  @override
  _OfflineSongsListState createState() => _OfflineSongsListState();
}

class _OfflineSongsListState extends State<OfflineSongsList> {
  int _selectedIndex;
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
    return FutureBuilder(
      future: AudioQuery.getLocalSongs(),
      builder: (BuildContext context, AsyncSnapshot<List<SongInfo>> snapshot) {
        if (snapshot.connectionState == ConnectionState.none ||
            !snapshot.hasData) {
          return Text('No songs');
        } else if (snapshot.hasData) {
          List<SongInfo> songs = snapshot.data;
          songPlayer.songsList = songs;

          return ListView.builder(
            itemCount: songs.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.blueGrey.withOpacity(0.6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  selected: index == _selectedIndex,
                  onTap: () {
                    songPlayer.play(index);
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  leading: songs[index].albumArtwork == null
                      ? CircleAvatar(
                          backgroundColor: colors[
                              index % colors.length] /*Colors.blueAccent*/,
                          child: Icon(Icons.audiotrack_rounded),
                          radius: 20.0,
                        )
                      : null,
                  title: Text(
                    songs[index].title,
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
