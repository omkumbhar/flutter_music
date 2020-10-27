import 'package:flutter_audio_query/flutter_audio_query.dart';

class AudioQuery {
  static final FlutterAudioQuery _audioQuery = FlutterAudioQuery();
  static List<SongInfo> songs;

  static Future<List<SongInfo>> getLocalSongs() async {
    if (songs != null) {
      return songs;
    } else {
      songs = await _audioQuery.getSongs(sortType: SongSortType.DISPLAY_NAME);
      return songs;
    }
    // songs.forEach((song) {
    //   print("${song.displayName}    ${song.filePath}");
    // });
  }
}
