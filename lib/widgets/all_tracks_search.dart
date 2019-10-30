import 'package:flutter/material.dart';

import '../styleguide.dart';
import '../dummydata.dart';
import '../widgets/all_tracks_search_letter.dart';

class AllTracksSearch extends StatelessWidget {
  final String currentLetter;
  final Function feedbackFunction;

  AllTracksSearch(
    this.currentLetter,
    this.feedbackFunction,
  );

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      child: Container(
        height: MediaQuery.of(context).size.height * .6,
        alignment: Alignment.topRight,
        child: Container(
          width: 25,
          margin: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 10.0,
          ),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              const Radius.circular(5.0),
            ),
            border: Border.all(
              color: textLightColor.withOpacity(0.5),
              width: 0.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              for (String letter in letters)
                AllTracksSearchLetter(
                  letter,
                  feedbackFunction,
                  currentLetter == letter,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
