//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_music/constants.dart';

Future<void> createSongDoc(SongInfo songInfo, String downloadURL) async {
  var song = Map<String, dynamic>();
  song["artist_name"] = songInfo.artist;
  song["image_url"] = null;
  song["song_language"] = null;
  song["song_name"] = songInfo.title;
  song["song_url"] = downloadURL;

  return await firebaseFirestore
      .collection("UsersUpload")
      .doc("uploads")
      .collection(firebaseUser.uid)
      .doc()
      .set(song)
      .then((value) => print("Song added "))
      .catchError((error) => print("Failed to add song: $error"));
}
