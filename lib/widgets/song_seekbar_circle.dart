import 'package:flutter/material.dart';

import '../styleguide.dart';

class SongSeekbarCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: textLightColor.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
    );
  }
}
