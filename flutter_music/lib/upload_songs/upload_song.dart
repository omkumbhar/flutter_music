import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

//class SongUpload {

void uploadSong(String songPath) {
  print("uploadSong called");
  FirebaseStorage storage = FirebaseStorage.instance;
  File file = File(songPath);
  file.path;
  String fileName = "omkar.mp3";
  UploadTask uploadTask = storage.ref("UserUploads/$fileName").putFile(file);
  //uploadTask.snapshot.totalBytes;
  uploadTask.snapshotEvents.listen((event) {
    print(event.bytesTransferred);
  });
  //bytesTransferred;
}
//}
