import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_music/constants.dart';

// ignore: must_be_immutable
class SongControls extends StatefulWidget {
  Function callback;
  SongControls({this.callback});

  @override
  _SongControlsState createState() => _SongControlsState();
}

class _SongControlsState extends State<SongControls> {
  SongInfo song = songPlayer.getCurrentSong;
  bool isView;
  bool playStopButton = true;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;

  @override
  void initState() {
    isView = true;
    songPlayer.getInstance.onAudioPositionChanged.listen((Duration p) {
      if (isView)
        setState(() {
          _position = p;
        });
    });
    songPlayer.getInstance.onDurationChanged.listen((d) {
      if (isView)
        setState(() {
          _duration = d;
        });
    });

    super.initState();
  }

  @override
  void dispose() {
    isView = false;
    super.dispose();
  }

  Widget _iconButton(IconData icon, VoidCallback callback) {
    return IconButton(
        icon: Icon(
          icon,
          size: 80.0,
          color: Colors.white.withOpacity(0.7),
        ),
        onPressed: callback);
  }

  String toMinute(Duration duration) {
    double minutes = duration.inSeconds / 60;
    int min = minutes.toInt();
    return ("$min:${((minutes - min) * 100).toInt()}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue.shade900 /*Colors.deepPurpleAccent*/,
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 8.0,
          ),
          Slider(
            value: _position.inSeconds.toDouble(),
            activeColor: Colors.pinkAccent,
            max: _duration.inSeconds.toDouble() /*double.parse(song.duration)*/,
            onChanged: (double value) {
              setState(() {
                songPlayer.seekSong(value.toInt());
                value = value;
              });
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(toMinute(_position),
                    style: TextStyle(
                      color: Colors.white,
                    )),
                Text(toMinute(_duration),
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            children: [
              Spacer(
                flex: 1,
              ),
              _iconButton(Icons.fast_rewind_rounded, () {
                songPlayer.previousSong();
                this.widget.callback(songPlayer?.getCurrentSong);
              }),
              Spacer(
                flex: 1,
              ),
              _iconButton(playStopButton ? Icons.play_arrow : Icons.pause, () {
                setState(() {
                  if (playStopButton) {
                    playStopButton = false;
                    songPlayer.pause();
                  } else {
                    playStopButton = true;
                    songPlayer.resume();
                  }
                });
              }),
              Spacer(
                flex: 1,
              ),
              _iconButton(Icons.fast_forward_rounded, () {
                //print("button pressed");
                songPlayer.nextSong();

                //print(" current song ${songPlayer.getCurrentSong.title}");
                this.widget.callback(songPlayer?.getCurrentSong);
              }),
              Spacer(
                flex: 2,
              ),
            ],
          )
        ],
      ),
    );
  }
}
