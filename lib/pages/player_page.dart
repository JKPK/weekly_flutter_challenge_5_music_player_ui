
import 'package:flutter/material.dart';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

typedef void OnError(Exception exception);

class PlayerPage extends StatefulWidget {
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  AudioPlayer _audioPlayer;
  static AudioCache _audioCache;
  AudioPlayerState _audioPlayerState;
  Duration _duration = Duration();
  Duration _position = Duration();

  @override
  void initState() {
    super.initState();

    _audioPlayer = AudioPlayer();

    _audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        _duration = duration;
      });
    });

    _audioPlayer.onAudioPositionChanged.listen((Duration position) {
      setState(() {
        _position = position;
      });
    });

    _audioPlayer.onPlayerStateChanged.listen((AudioPlayerState state) {
      setState(() {
        _audioPlayerState = state;
      });

      switch (_audioPlayerState) {
        case AudioPlayerState.COMPLETED:
          setState(() {
            _position = Duration();
            _duration = Duration();
          });
          break;
        case AudioPlayerState.PAUSED:
          break;
        case AudioPlayerState.PLAYING:
          break;
        case AudioPlayerState.STOPPED:
          setState(() {
            _position = Duration();
            _duration = Duration();
          });
          break;
      }
    });

    _audioCache = AudioCache(
      prefix: 'music/',
      fixedPlayer: _audioPlayer,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  _audioCache.play('Lav_-_standing_on_the_edge.mp3');
                },
                child: Text("PLAY"),
              ),
              RaisedButton(
                onPressed: () {
                  _audioPlayer.pause();
                },
                child: Text("PAUSE"),
              ),
              RaisedButton(
                onPressed: () {
                  _audioPlayer.stop();
                },
                child: Text("STOP"),
              ),
              Text("Duration: $_duration"),
              Text("Position: $_position"),
            ],
          ),
        ),
      ),
    );
  }
}
