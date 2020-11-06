import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_music/constants.dart';

class FirebaseQuery {
  static final FirebaseQuery _firebaseQuery = FirebaseQuery._internal();
  CollectionReference collectionReference;
  String collection;
  FirebaseQuery._internal();

  factory FirebaseQuery({String collection}) {
    if (_firebaseQuery == null) {
      _firebaseQuery.collectionReference =
          firebaseFirestore.collection(collection ?? "song");
      return _firebaseQuery;
    } else {
      return _firebaseQuery;
    }
  }

  CollectionReference getCollectionReference() {
    return _firebaseQuery.collectionReference;
  }
  /*Stream<void> getDocuments() async* {
    Stream<QuerySnapshot> querySnapshot =
        collectionReference.orderBy("song_name").snapshots();
  }*/
}
