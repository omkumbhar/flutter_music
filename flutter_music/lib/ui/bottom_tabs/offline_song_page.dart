import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_music/constants.dart';
import 'package:flutter_music/local_songs/audio_query.dart';
import 'package:flutter_music/ui/song_list_widgets/song_list_view.dart';

class OfflineSongsList extends StatefulWidget {
  @override
  _OfflineSongsListState createState() => _OfflineSongsListState();
}

class _OfflineSongsListState extends State<OfflineSongsList> {
  int _selectedIndex;
  void callBack(int index) {
    songPlayer.play(index);
    setState(() {
      _selectedIndex = index;
    });
  }

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
              return songListTile(
                  songName: songs[index].title,
                  index: index,
                  isSelected: index == _selectedIndex,
                  callback: callBack);
            },
          );
        }
        return null;
      },
    );
  }
}
