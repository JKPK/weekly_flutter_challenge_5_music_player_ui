import 'package:flutter/material.dart';

import '../styleguide.dart';

class AllTracksSearchLetter extends StatelessWidget {
  final String letter;
  final Function feedbackFunction;
  final bool isActive;

  AllTracksSearchLetter(
    this.letter,
    this.feedbackFunction,
    this.isActive,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        feedbackFunction(letter);
      },
      child: Container(
        child: Text(
          letter,
          style: TextStyle(
            color: isActive ? Colors.white : textLightColor,
            fontSize: 11,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
