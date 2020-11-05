import 'package:flutter_music/constants.dart';
import 'package:flutter_music/model/online_song.dart';

class OnlineSongPlayer {
  List<OnlineSong> _songs;
  int _position;

  static final OnlineSongPlayer _songPlayer = OnlineSongPlayer._internal();
  OnlineSongPlayer._internal();

  factory OnlineSongPlayer() => _songPlayer;

  set songsList(List<OnlineSong> songs) {
    this._songs = songs;
  }

  OnlineSong get getCurrentSong => _songs[_position];

  void play(int position) async {
    this._position = position;
    await audioPlayer.play(_songs[_position].songUrl);
  }

  void seekSong(int millisecond) {
    Duration duration = Duration(seconds: millisecond);
    audioPlayer.seek(duration);
  }

  void nextSong() {
    int nextPosition = ++_position;

    if (nextPosition < _songs.length)
      this.play(nextPosition);
    else
      this.play(0);
  }

  void previousSong() {
    int previousPosition = --_position;

    if (previousPosition < 0)
      this.play(--_songs.length);
    else
      this.play(previousPosition);
  }

  void pause() async => await audioPlayer.pause();
  void resume() async => await audioPlayer.resume();
}
