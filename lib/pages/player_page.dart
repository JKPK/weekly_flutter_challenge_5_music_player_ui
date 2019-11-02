import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../styleguide.dart';
import '../providers/player_provider.dart';
import '../widgets/player_recent_playlist.dart';
import '../widgets/player_current_song.dart';
import '../widgets/app_title.dart';
import '../widgets/all_tracks.dart';

typedef void OnError(Exception exception);

class PlayerPage extends StatefulWidget {
  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage>
    with SingleTickerProviderStateMixin {
  Animation<double> _pageAnimation;
  AnimationController _pageController;
  double panStartY;
  double panPosY = 0;
  double panStartAnimation;

  final StreamController _streamController = StreamController.broadcast();

  @override
  void initState() {
    super.initState();

    _pageController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    _pageAnimation = Tween<double>(begin: 0, end: 1).animate(_pageController)
      ..addListener(
        () {
          _streamController.sink.add(_pageController.value);
        },
      );
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  void startPan(double posY) {
    panStartY = posY;
    panStartAnimation = _pageController.value;
    panPosY = 0;
  }

  void endPan(Velocity velocity) {
    if (panStartAnimation == 0) {
      if (velocity.pixelsPerSecond.dy < -50) {
        _pageController.animateTo(1);
      } else {
        _pageController.animateTo(0);
      }
    } else {
      if (velocity.pixelsPerSecond.dy > 50) {
        _pageController.animateTo(0);
      } else {
        _pageController.animateTo(1);
      }
    }
  }

  void updatePan(double offsetY) {
    panPosY += offsetY;
    if (panStartAnimation == 0) {
      if (panPosY > 0) {
        panPosY = 0;
      }
      _pageController.value =
          (panPosY.abs() / MediaQuery.of(context).size.height);
    }
    if (panStartAnimation == 1) {
      if (panPosY < 0) {
        panPosY = 0;
      }
      _pageController.value =
          1 - (panPosY.abs() / MediaQuery.of(context).size.height);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

    return Scaffold(
      backgroundColor: backgroundDarkColor,
      body: ChangeNotifierProvider(
        builder: (context) => PlayerProvider(),
        child: Stack(
          children: <Widget>[
            PlayerCurrentSong(1 - _pageController.value),
            StreamBuilder(
              stream: _streamController.stream,
              initialData: 0.0,
              builder: (context, snapshot) {
                return Positioned(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.7,
                  top:
                      MediaQuery.of(context).size.height * (.7 - snapshot.data),
                  child: GestureDetector(
                    onPanStart: (drag) {
                      startPan(drag.globalPosition.dy);
                    },
                    onPanEnd: (drag) {
                      endPan(drag.velocity);
                    },
                    onPanUpdate: (drag) {
                      updatePan(drag.delta.dy);
                    },
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          PlayerRecentPlaylist("Recent Playlist"),
                          Container(
                            height: MediaQuery.of(context).size.height * .1,
                            decoration:
                                BoxDecoration(gradient: secondPageGradient),
                            child: AppTitle("Tracks"),
                          ),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              child: PlayerRecentPlaylist(
                                "Recently Added Tracks",
                                true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            AllTracks(_streamController.stream),
            CornerButton(
              icon: Icons.menu,
              corner: CornerPositions.topLeft,
            ),
            CornerButton(
              icon: Icons.search,
              corner: CornerPositions.topRight,
            ),
          ],
        ),
      ),
    );
  }
}
