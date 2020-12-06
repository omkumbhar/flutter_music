import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_music/upload_songs/create_song_doc.dart';
import 'package:flutter_music/upload_songs/upload_song.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class UploadSongView extends StatefulWidget {
  final List<SongInfo> selectedSongs;
  UploadSongView(this.selectedSongs);

  @override
  _UploadSongViewState createState() => _UploadSongViewState();
}

class _UploadSongViewState extends State<UploadSongView> {
  double s = double.maxFinite;

/*  Card listItem({String songName, double width, Stream<int> stream}) {
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
  }*/

  @override
  Widget build(BuildContext context) {
    List<SongInfo> songs = widget.selectedSongs;
    return Scaffold(
      body: SafeArea(
          child: ListView.separated(
              itemBuilder: (context, index) {
                return UploadListItem(songs[index]);
                /*listItem(songName: songs[index].title);*/
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 10.0,
                );
              },
              itemCount: songs.length)),
    );
  }

  @override
  void dispose() {
    widget.selectedSongs.clear();
    super.dispose();
  }
}

class UploadListItem extends StatefulWidget {
  final SongInfo songInfo;

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

    uploadTask.whenComplete(() {
      createDoc();
      /*Navigator.push(
          context, MaterialPageRoute(builder: (context) => BottomBar()));*/
    });

    upload.getTotalBytes().listen((bytes) {
      totalBytes = bytes;
    });
    upload.getTransferredBytes().listen((bytes) {
      setState(() {
        width =
            (MediaQuery.of(context).size.width - 20.0) * (bytes / totalBytes);
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
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Shimmer(
        duration: Duration(seconds: 3), //Default value
        interval: Duration(seconds: 1), //Default value: Duration(seconds: 0)
        color: Colors.amberAccent, //Default value
        enabled: true, //Default value
        direction: ShimmerDirection.fromLeftToRight(),
        child: Stack(
          //alignment: Alignment.center,
          children: [
            Positioned(
              left: 0,
              child: Container(
                height: 60.0,
                width: width ?? 0.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.greenAccent.shade700),
              ),
            ),
            Container(
              height: 60.0,
              width: double.maxFinite,
              child: Center(
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    "${song.title.length > 35 ? song.title.substring(0, 35) + "..." : song.title}",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: Colors.greenAccent),
                  color: Colors.transparent),
            )
          ],
        ),
      ),
    );
  }
}
