import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_music/constants.dart';

class SongUpload {
  String songPath;
  String fileName;
  UploadTask uploadTask;
  SongUpload(this.songPath, this.fileName);

  UploadTask uploadSong() {
    FirebaseStorage storage = FirebaseStorage.instance;
    File file = File(songPath);

    UploadTask uploadTask =
        storage.ref("UserUploads/${firebaseUser.uid}/$fileName").putFile(file);
    this.uploadTask = uploadTask;
    return uploadTask;
    /*uploadTask.snapshotEvents.listen((event) {
      print(event.bytesTransferred);
      event.ref.getDownloadURL();
    });*/

    //bytesTransferred;
  }

  Future<String> get songUrl => this.uploadTask.snapshot.ref.getDownloadURL();

  Stream<int> getTotalBytes() async* {
    await for (var i in uploadTask.snapshotEvents) {
      yield i.totalBytes;
    }
  }

  Stream<int> getTransferredBytes() async* {
    await for (var i in uploadTask.snapshotEvents) {
      yield i.bytesTransferred;
    }
  }
}
