import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_music/constants.dart';

Future<void> createDoc(User user) async {
  if (!await isUserPresent(user.uid)) {
    var map = Map<String, dynamic>();
    map["name"] = user.displayName;
    map["email"] = user.email;
    map["photoURL"] = user.photoURL;

    return await firebaseFirestore
        .collection("Users")
        .doc(user.uid)
        .set({
          "name": user.displayName,
          "email": user.email,
          "photoURL": user.photoURL
        })
        .then((value) => print("User added "))
        .catchError((error) => print("Failed to add user: $error"));
  }
}

Future<bool> isUserPresent(String id) async => await firebaseFirestore
    .collection("Users")
    .doc(id)
    .get()
    .then((doc) => doc.exists);
