import 'package:flutter/material.dart';
import 'package:pandabar/pandabar.dart';

import 'bottom_tabs/offline_song_page.dart';
import 'bottom_tabs/onlline_song_pages/online_song_page.dart';
import 'bottom_tabs/onlline_song_pages/online_songs_home.dart';
import 'playing_song_screen/playing_screen.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  String page = 'Offline';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10
      /*Colors.black54.withOpacity(0.5) Colors.blue.shade900*/,
      extendBody: true,
      bottomNavigationBar: PandaBar(
        backgroundColor: Colors.cyan.shade300,
        buttonData: [
          PandaBarButtonData(
              id: 'Offline', icon: Icons.cloud_off, title: 'Offline'),
          PandaBarButtonData(
              id: 'Online', icon: Icons.cloud_outlined, title: 'Online'),
          PandaBarButtonData(
              id: 'Red', icon: Icons.account_balance_wallet, title: 'Red'),
          PandaBarButtonData(
              id: 'Yellow', icon: Icons.notifications, title: 'Yellow'),
        ],
        onChange: (id) {
          setState(() {
            page = id;
          });
        },
        onFabButtonPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MusicPlayer()));

//          setState(() {
//            page = "Player";
//          });
        },
        fabColors: [Colors.transparent, Colors.transparent],
        fabIcon: Hero(
          tag: "music-img",
          child: CircleAvatar(
            backgroundColor: Colors.redAccent,
            backgroundImage: AssetImage("images/music_Logo.jpg"),
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
              return OnlineSongList();
            case 'Red':
              return OnlineHome();
            case 'Yellow':
              return Container(color: Colors.yellow.shade700);
            case "Player":
              return MusicPlayer();
            default:
              return Container();
          }
        },
      ),
    );
  }
}
