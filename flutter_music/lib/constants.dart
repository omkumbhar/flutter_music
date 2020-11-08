import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'players/local_song_player/player.dart';
import 'players/online_song_player/onilne_player.dart';

bool isLocalPlayed = true;
final AudioPlayer audioPlayer = AudioPlayer();
final SongPlayer songPlayer = SongPlayer();
final OnlineSongPlayer onlineSongPlayer = OnlineSongPlayer();

final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
User firebaseUser;
