import 'package:flutter/material.dart';
import 'package:flutter_music/constants.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

Widget listItem(String title, String image, {List<Color> colors, double size}) {
  return Padding(
    padding: EdgeInsets.all(10.0),
    child: Shimmer(
      duration: Duration(seconds: 3), //Default value
      interval: Duration(seconds: 5), //Default value: Duration(seconds: 0)
      color: Colors.white, //Default value
      enabled: true, //Default value
      direction: ShimmerDirection.fromLTRB(),
      child: Container(
        height: size ?? 170.0,
        width: size ?? 170.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          gradient: LinearGradient(
            colors: colors ??
                [
                  PINK.withOpacity(0.6),
                  YELLOW.withOpacity(0.6),
                ],
            begin: Alignment.centerLeft,
            end: Alignment(1.0, 1.0),
          ),
        ),
        child: Stack(
          children: [
            Opacity(
              opacity: 0.3,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Center(
              child: Column(
                /*mainAxisAlignment: MainAxisAlignment.center,*/
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: TEXT_COLOR_WHITE,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
