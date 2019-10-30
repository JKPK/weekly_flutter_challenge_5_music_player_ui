import 'package:flutter/material.dart';

import '../styleguide.dart';

class AllTracksTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: Text(
        "All Tracks",
        style: TextStyle(color: textLightColor, fontSize: 15),
      ),
    );
  }
}