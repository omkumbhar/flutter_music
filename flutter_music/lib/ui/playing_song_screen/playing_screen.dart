import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_music/constants.dart';
import 'package:flutter_music/ui/playing_song_screen/playing_screen_controlls.dart';

class MusicPlayer extends StatefulWidget {
  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  SongInfo song = songPlayer.getCurrentSong;

  void callback(SongInfo song) {
    setState(() {
      this.song = song;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.black,
              child: Stack(
                children: [
                  Hero(
                    tag: "music-img",
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("images/music_Logo.jpg"),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                          Colors.pink.shade400.withOpacity(0.4),
//                          Colors.deepPurpleAccent
                          Colors.blue.shade900
                        ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Spacer(
                          flex: 1,
                        ),
                        Text(
                          "",
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontWeight: FontWeight.bold,
                              fontSize: 30.0),
                        ),
                        Spacer(
                          flex: 8,
                        ),
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            "${song?.title}",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0,
                                shadows: [
                                  Shadow(
                                    blurRadius: 1.0,
                                    color: Colors.white.withOpacity(0.1),
                                    offset: Offset(5.0, 5.0),
                                  ),
                                ]),
                          ),
                        ),
                        Text(
                          "${song?.artist}",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SongControls(
              callback: callback,
            ),
          )
        ],
      ),
    );
  }
}
