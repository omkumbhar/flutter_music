import 'package:flutter/material.dart';
import 'package:flutter_music/constants.dart';
import 'package:flutter_music/ui/bottom_tabs/uploaded_song_screen/uploaded_song.dart';
import 'package:pandabar/pandabar.dart';

import 'bottom_tabs/offline_song_page.dart';
import 'bottom_tabs/onlline_song_pages/online_song_page.dart';
import 'bottom_tabs/onlline_song_pages/online_songs_home.dart';
import 'bottom_tabs/profile/profile.dart';
import 'playing_song_screen/playing_screen.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  String page = 'Offline';
  String query;
  void setPage(String newPage) {
    setState(() {
      query = newPage;
      page = 'Online_query';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VIOLET,
      extendBody: true,
      bottomNavigationBar: PandaBar(
        buttonColor: PINK,
        buttonSelectedColor: Colors.white,
        backgroundColor: YELLOW,
        buttonData: [
          PandaBarButtonData(
              id: 'Offline', icon: Icons.cloud_off, title: 'Offline'),
          PandaBarButtonData(
              id: 'Online', icon: Icons.cloud_outlined, title: 'Online'),
          PandaBarButtonData(
              id: 'UploadSong',
              icon: Icons.cloud_upload_outlined,
              title: 'My Space'),
          PandaBarButtonData(
              id: 'UserProfile',
              icon: Icons.account_circle_outlined,
              title: 'UserProfile'),
        ],
        onChange: (id) {
          setState(() {
            page = id;
          });
        },
        onFabButtonPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MusicPlayer()));
        },
        fabColors: [Colors.transparent, Colors.transparent],
        fabIcon: Hero(
          tag: "music-img",
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage("images/playing.png"),
            radius: 70.0,
          ),
        ),
      ),
      body: Builder(
        builder: (context) {
          switch (page) {
            case 'Offline':
              return OfflineSongsList();
            case 'Online':
              return OnlineHome(
                callback: setPage,
              );
            case 'Online_query':
              return OnlineSongList(
                songType: query,
              );
            case 'UploadSong':
              return UploadSong();

            case 'UserProfile':
              return Profile();
            default:
              return Container();
          }
        },
      ),
    );
  }
}
