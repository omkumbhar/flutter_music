import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_music/upload_songs/create_song_doc.dart';
import 'package:flutter_music/upload_songs/upload_song.dart';

class UploadSongView extends StatefulWidget {
  final List<SongInfo> selectedSongs;
  UploadSongView(this.selectedSongs);

  @override
  _UploadSongViewState createState() => _UploadSongViewState();
}

class _UploadSongViewState extends State<UploadSongView> {
  double s = double.maxFinite;

  Card listItem({String songName, double width, Stream<int> stream}) {
    return Card(
      child: Stack(
        children: [
          Container(
            height: 75.0,
            width: width ?? 200.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.greenAccent.shade700),
          ),
          Container(
            height: 75.0,
            width: double.maxFinite,
            child: Center(
              child: Text(songName),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.transparent),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<SongInfo> songs = widget.selectedSongs;
    /*ListView.separated(itemBuilder: (context, index) {
      SongUpload upload =
      SongUpload(songs[index].filePath, songs[index].displayName);
      upload.uploadSong();

      return UploadListItem(songs[index].title, upload.getTotalBytes(),
          upload.getTransferredBytes());
      */ /*listItem(songName: songs[index].title);*/ /*
    }, separatorBuilder: (context, index) {

      return SizedBox(height: 20.0,);

    }, itemCount: songs.length);*/
    return Scaffold(
      body: SafeArea(
          child: ListView.separated(
              itemBuilder: (context, index) {
                SongUpload upload =
                    SongUpload(songs[index].filePath, songs[index].displayName);
                //upload.uploadSong();

                return UploadListItem(songs[index]);
                /*listItem(songName: songs[index].title);*/
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 20.0,
                );
              },
              itemCount: songs.length)
          /*ListView.builder(
          itemCount: songs.length,
          itemBuilder: (context, index) {
            SongUpload upload =
                SongUpload(songs[index].filePath, songs[index].displayName);
            upload.uploadSong();

            return UploadListItem(songs[index].title, upload.getTotalBytes(),
                upload.getTransferredBytes());
            */ /*listItem(songName: songs[index].title);*/ /*
          },
        ),*/
          ),
    );
  }

  @override
  void dispose() {
    widget.selectedSongs.clear();
    super.dispose();
  }
}

class UploadListItem extends StatefulWidget {
  SongInfo songInfo;

  UploadListItem(this.songInfo);
  @override
  _UploadListItemState createState() => _UploadListItemState();
}

class _UploadListItemState extends State<UploadListItem> {
  SongInfo song;

  double width;
  int totalBytes;
  SongUpload upload;
  UploadTask uploadTask;
  @override
  void initState() {
    song = widget.songInfo;

    upload = SongUpload(song.filePath, song.displayName);
    uploadTask = upload.uploadSong();

    uploadTask.whenComplete(() => createDoc());

    upload.getTotalBytes().listen((bytes) {
      totalBytes = bytes;
    });
    upload.getTransferredBytes().listen((bytes) {
      setState(() {
        width = double.maxFinite * (bytes / totalBytes);
      });
    });

    super.initState();
  }

  void createDoc() async {
    String url = await upload.songUrl;
    createSongDoc(song, url);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            height: 75.0,
            width: width ?? 0.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.greenAccent.shade700),
          ),
          Container(
            height: 75.0,
            width: double.maxFinite,
            child: Center(
              child: Text(song.title),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.transparent),
          )
        ],
      ),
    );
  }
}
