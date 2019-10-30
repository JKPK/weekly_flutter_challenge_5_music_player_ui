import 'package:flutter/material.dart';

import '../dummydata.dart';

class AllTracksSearchIndicator extends StatelessWidget {
  final String letter;

  AllTracksSearchIndicator(this.letter);

  @override
  Widget build(BuildContext context) {
    int position = 0;
    for (int i = 0; i < letters.length; i++) {
      if (letter == letters[i]) {
        position = i;
        break;
      }
    }

    return Positioned(
      top: -5 +
          position *
              (MediaQuery.of(context).size.height * .575) /
              letters.length,
      right: 70,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Color(0xCCC56970),
                Color(0xCCD09d7c),
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 2,
                spreadRadius: 1,
              )
            ]),
        child: Center(
          child: Text(
            letter,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white70,
            ),
          ),
        ),
      ),
    );
  }
}
