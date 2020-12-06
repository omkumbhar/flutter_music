import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_music/constants.dart';
import 'package:flutter_music/local_songs/audio_query.dart';

import 'upload_visuals.dart';

List<Color> colors = [
  Colors.teal[600],
  Colors.green[600],
  Colors.lime[600],
  Colors.amber[600],
  Colors.deepOrange[600],
  Colors.cyan[600]
];

class UploadScreen extends StatefulWidget {
  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  List<int> _selectedIndex = List<int>();
  List<SongInfo> selectedSongs = List<SongInfo>();
  List<SongInfo> songs = List<SongInfo>();

  void addToSelected(int selectedIndex) {
    setState(() {
      _selectedIndex.contains(selectedIndex)
          ? _selectedIndex.remove(selectedIndex)
          : _selectedIndex.add(selectedIndex);
    });
  }

  Card songListTile(
      {String songName, int index, bool isSelected, Function callback}) {
    return Card(
      color: isSelected
          ? Colors.blue.withOpacity(0.6)
          : Colors.blueGrey.withOpacity(0.6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        //selected: isSelected,
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

  Widget fabButton() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.elliptical(10.0, 10.0))),
      /*width: double.maxFinite,*/
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: ElevatedButton(
        onPressed: () {
          _selectedIndex.forEach((index) {
            selectedSongs.add(songs[index]);
          });

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UploadSongView(selectedSongs)));
        },
        style: ButtonStyle(
            overlayColor:
                MaterialStateProperty.all<Color>(Colors.grey.withOpacity(0.6)),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shadowColor:
                MaterialStateProperty.all<Color>(Colors.white.withOpacity(0.5)),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.all(5.0))),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              child: Icon(
                Icons.cloud_upload,
                size: 25.0,
                color: VIOLET,
              ),
              padding: EdgeInsets.only(right: 5.0),
            ),
            Text(
              "Upload selected songs",
              style: TextStyle(
                  color: Colors.lightBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*floatingActionButton: fabButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,*/
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        backgroundColor: VIOLET,
        title: Text('Selected ${_selectedIndex.length}'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.cloud_upload,
              size: 25.0,
              color: Colors.white,
            ),
            tooltip: 'Upload Songs',
            onPressed: () {
              _selectedIndex.forEach((index) {
                selectedSongs.add(songs[index]);
              });

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UploadSongView(selectedSongs)));
            },
          )
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: AudioQuery.getLocalSongs(),
          builder:
              (BuildContext context, AsyncSnapshot<List<SongInfo>> snapshot) {
            if (snapshot.connectionState == ConnectionState.none ||
                !snapshot.hasData) {
              return Text('No songs');
            } else if (snapshot.hasData) {
              songs = snapshot.data;
              return ListView.builder(
                /*shrinkWrap: true,*/
                itemCount: songs.length,
                itemBuilder: (context, index) {
                  return songListTile(
                      songName: songs[index].title,
                      index: index,
                      isSelected: _selectedIndex.contains(index),
                      callback: addToSelected);
                },
              );
            }
            return null;
          },
        ),
      ),
    );
  }
}
