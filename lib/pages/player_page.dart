import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../styleguide.dart';
import '../providers/player_provider.dart';
import '../widgets/player_recent_playlist.dart';
import '../widgets/player_current_song.dart';

typedef void OnError(Exception exception);

class PlayerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

    return Scaffold(
      backgroundColor: backgroundDarkColor,
      body: ChangeNotifierProvider(
        builder: (context) => PlayerProvider(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            PlayerCurrentSong(),
            PlayerRecentPlaylist(),
          ],
        ),
      ),
    );
  }
}
