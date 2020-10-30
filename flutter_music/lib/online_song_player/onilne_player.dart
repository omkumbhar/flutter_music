import 'package:audioplayers/audioplayers.dart';

final AudioPlayer audioPlayer = AudioPlayer();

class OnlineSongPlayer {
  static final OnlineSongPlayer _songPlayer = OnlineSongPlayer._internal();
  OnlineSongPlayer._internal();

  factory OnlineSongPlayer() => _songPlayer;

  void songPlayer(String song) async {
    await audioPlayer.play(song);
  }

  void seekSong(int millisecond) {
    Duration duration = Duration(seconds: millisecond);
    audioPlayer.seek(duration);
  }

  void pause() async => await audioPlayer.pause();
  void resume() async => await audioPlayer.resume();
}
