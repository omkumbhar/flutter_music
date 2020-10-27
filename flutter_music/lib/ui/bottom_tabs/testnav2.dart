import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _bottomNavIndex = 1;
  List<IconData> iconList = [Icons.cloud, Icons.satellite_sharp,];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   body: Container(), //destination screen
   floatingActionButton: FloatingActionButton(
      //params
      onPressed: (){},
   ),
   floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
   bottomNavigationBar: AnimatedBottomNavigationBar(
      icons: iconList,
      activeIndex: _bottomNavIndex,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.verySmoothEdge,
      leftCornerRadius: 32,
      rightCornerRadius: 32,
      onTap: (index) => setState(() => _bottomNavIndex = index),
      //other params
   ),
);
  }
}
