import 'package:flutter/material.dart';
import 'package:flutter_music/ui/upload_song_screen/upload_song.dart';

class UploadSong extends StatefulWidget {
  @override
  _UploadSongState createState() => _UploadSongState();
}

class _UploadSongState extends State<UploadSong> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => UploadScreen()));
          },
          style: ButtonStyle(
              overlayColor: MaterialStateProperty.all<Color>(
                  Colors.grey.withOpacity(0.6)),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              shadowColor: MaterialStateProperty.all<Color>(
                  Colors.white.withOpacity(0.5)),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.all(5.0))),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                child: Image(
                  image: AssetImage("images/google_logo.png"),
                  height: 25.0,
                  width: 25.0,
                ),
                padding: EdgeInsets.only(right: 5.0),
              ),
              Text(
                "Upload",
                style: TextStyle(
                    color: Colors.lightBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
