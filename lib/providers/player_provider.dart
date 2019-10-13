import 'package:flutter/material.dart';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class PlayerProvider extends ChangeNotifier {
  static AudioCache _audioCache;
  AudioPlayer _audioPlayer;
  AudioPlayerState _audioPlayerState;
  Duration _duration = Duration();
  Duration _position = Duration();

  AudioCache get audioCache => _audioCache;

  AudioPlayer get audioPlayer => _audioPlayer;

  AudioPlayerState get audioPlayerState => _audioPlayerState;

  Duration get duration => _duration;

  Duration get position => _position;

  PlayerProvider() {
    _audioPlayer = AudioPlayer();

    _audioPlayer.onDurationChanged.listen((Duration duration) {
      _duration = duration;
      notifyListeners();
    });

    _audioPlayer.onAudioPositionChanged.listen((Duration position) {
      _position = position;
      notifyListeners();
    });

    _audioPlayer.onPlayerStateChanged.listen((AudioPlayerState state) {
      _audioPlayerState = state;
      notifyListeners();

      switch (_audioPlayerState) {
        case AudioPlayerState.PLAYING:
          break;
        case AudioPlayerState.PAUSED:
          break;
        case AudioPlayerState.COMPLETED:
          _position = Duration();
          _duration = Duration();
          notifyListeners();
          break;
        case AudioPlayerState.STOPPED:
          _position = Duration();
          _duration = Duration();
          notifyListeners();
          break;
      }
    });

    _audioCache = AudioCache(
      prefix: 'music/',
      fixedPlayer: _audioPlayer,
    );
  }
}
