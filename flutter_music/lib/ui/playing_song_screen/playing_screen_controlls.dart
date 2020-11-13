import 'package:flutter/material.dart';
import 'package:flutter_music/constants.dart';

// ignore: must_be_immutable
class SongControls extends StatefulWidget {
  Function callback;
  SongControls({this.callback});

  @override
  _SongControlsState createState() => _SongControlsState();
}

class _SongControlsState extends State<SongControls> {
  dynamic song;
  bool isView;
  bool playStopButton = true;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;

  @override
  void initState() {
    song = isLocalPlayed
        ? songPlayer.getCurrentSong
        : onlineSongPlayer.getCurrentSong;
    isView = true;
    audioPlayer.onAudioPositionChanged.listen((Duration p) {
      if (isView)
        setState(() {
          _position = p;
        });
    });
    audioPlayer.onDurationChanged.listen((d) {
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
    return GestureDetector(
      onTap: callback,
      child: Container(
        /*height: 80.0,
        width: 50.0,*/
        child: Icon(icon, size: 90.0, color: Colors.white.withOpacity(0.7)),
      ),
    );
  }

  String toMinute(Duration duration) {
    double minutes = duration.inSeconds / 60;
    int min = minutes.toInt();
    return ("$min:${((minutes - min) * 100).toInt()}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PINK /*Colors.blue.shade900 Colors.deepPurpleAccent*/,
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
                flex: 2,
              ),
              _iconButton(Icons.fast_rewind_rounded, () {
                if (isLocalPlayed) {
                  songPlayer.previousSong();
                  this.widget.callback(songPlayer?.getCurrentSong);
                } else {
                  onlineSongPlayer.previousSong();
                  this.widget.callback(onlineSongPlayer?.getCurrentSong);
                }
              }),
              Spacer(
                flex: 1,
              ),
              _iconButton(playStopButton ? Icons.pause : Icons.play_arrow, () {
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
                if (isLocalPlayed) {
                  songPlayer.nextSong();
                  this.widget.callback(songPlayer?.getCurrentSong);
                } else {
                  onlineSongPlayer.nextSong();
                  this.widget.callback(onlineSongPlayer?.getCurrentSong);
                }
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
