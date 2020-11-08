import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_music/constants.dart';

class SongPlayer {
  List<SongInfo> _songs;
  int _position;

  static final SongPlayer _songPlayer = SongPlayer._internal();
  SongPlayer._internal();

  factory SongPlayer() => _songPlayer;

  AudioPlayer get getInstance => audioPlayer;

  set songsList(List<SongInfo> songs) {
    this._songs = songs;
  }

  SongInfo get getCurrentSong => _songs[_position];

  void play(int position) async {
    this._position = position;
    await audioPlayer.play(_songs[_position].filePath);
  }

  void seekSong(int millisecond) {
    Duration duration = Duration(seconds: millisecond);
    audioPlayer.seek(duration);
  }

  void nextSong() {
    int nextPosition = ++_position == _songs.length ? 0 : _position;
    this.play(nextPosition);
  }

  void previousSong() {
    int previousPosition = _position == 0 ? (_songs.length - 1) : --_position;
    this.play(previousPosition);
  }

  void pause() async => await audioPlayer.pause();
  void resume() async => await audioPlayer.resume();
}
