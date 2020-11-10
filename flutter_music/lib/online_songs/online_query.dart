import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_music/constants.dart';

class FirebaseQuery {
  CollectionReference collectionReference;
  String collection;

  FirebaseQuery({String collection}) {
    collectionReference = firebaseFirestore.collection(collection ?? 'songs');
  }

  CollectionReference getCollectionReference() => collectionReference;

  Stream<QuerySnapshot> getSongs({String songType}) async* {
    await for (var song in this
        .getCollectionReference()
        .where('song_language', isEqualTo: songType ?? 'marathi')
        //.orderBy('artist_name')
        //.orderBy('song_name')
        .snapshots()) {
      yield song;
    }
  }

  Stream<QuerySnapshot> getUploadedSongs() async* {
    await for (var song in this
        .getCollectionReference()
//        .where('song_language', isEqualTo: songType ?? 'marathi')
        //.orderBy('artist_name')
        //.orderBy('song_name')
        .snapshots()) {
      yield song;
    }
  }
}
