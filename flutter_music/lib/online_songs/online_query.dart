import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseQuery {
  static final FirebaseQuery _firebaseQuery = FirebaseQuery._internal();
  FirebaseFirestore firebaseFirestore;
  CollectionReference collectionReference;
  String collection;
  FirebaseQuery._internal();

  factory FirebaseQuery({String collection}) {
    if (_firebaseQuery == null) {
      Firebase.initializeApp();
      _firebaseQuery.firebaseFirestore = FirebaseFirestore.instance;
      _firebaseQuery.collectionReference =
          _firebaseQuery.firebaseFirestore.collection(collection ?? "song");
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
