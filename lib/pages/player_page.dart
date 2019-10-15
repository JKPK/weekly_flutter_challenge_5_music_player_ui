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

    /*Scaffold(
      backgroundColor: backgroundColor,
      body: ChangeNotifierProvider(
        builder: (context) => PlayerProvider(),
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Consumer<PlayerProvider>(
                  builder: (context, notifier, child) {
                    Duration duration =
                        Provider.of<PlayerProvider>(context).duration;
                    Duration position =
                        Provider.of<PlayerProvider>(context).position;
                    return Column(
                      children: <Widget>[
                        RaisedButton(
                          onPressed: () {
                            Provider.of<PlayerProvider>(context, listen: false)
                                .audioCache
                                .play('Lav_-_standing_on_the_edge.mp3');
                          },
                          child: Text("PLAY"),
                        ),
                        RaisedButton(
                          onPressed: () {
                            Provider.of<PlayerProvider>(context, listen: false)
                                .audioPlayer
                                .pause();
                          },
                          child: Text("PAUSE"),
                        ),
                        RaisedButton(
                          onPressed: () {
                            Provider.of<PlayerProvider>(context, listen: false)
                                .audioPlayer
                                .stop();
                          },
                          child: Text("STOP"),
                        ),
                        Text(
                          "Duration: $duration",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "Position: $position",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );*/
  }
}
