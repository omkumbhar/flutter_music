import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'players/local_song_player/player.dart';
import 'players/online_song_player/onilne_player.dart';

bool isLocalPlayed = true;
final AudioPlayer audioPlayer = AudioPlayer();
final SongPlayer songPlayer = SongPlayer();
final OnlineSongPlayer onlineSongPlayer = OnlineSongPlayer();

final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
User firebaseUser;

const Color VIOLET = Color.fromRGBO(65, 55, 107, 1);

const Color YELLOW = Color.fromRGBO(252, 193, 89, 1);

const Color PINK = Color.fromRGBO(181, 96, 137, 1);

const Color TEXT_COLOR_WHITE = Color.fromRGBO(236, 239, 244, 1);
