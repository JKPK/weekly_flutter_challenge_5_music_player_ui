import 'package:flutter/material.dart';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

import '../dummydata.dart';

class PlayerProvider extends ChangeNotifier {
  static const List<Map<String, String>> _songsData = playableSongsData;
  static AudioCache _audioCache;
  AudioPlayer _audioPlayer;
  AudioPlayerState _audioPlayerState;
  Duration _duration = Duration();
  Duration _position = Duration();
  int _songId = 0;

  AudioCache get audioCache => _audioCache;

  AudioPlayer get audioPlayer => _audioPlayer;

  AudioPlayerState get audioPlayerState => _audioPlayerState;

  Duration get duration => _duration;

  Duration get position => _position;

  bool get isPlaying => _audioPlayerState == AudioPlayerState.PLAYING;

  int get songId => _songId;

  String getArtist() {
    if (_audioPlayerState == AudioPlayerState.PLAYING ||
        _audioPlayerState == AudioPlayerState.PAUSED) {
      return _songsData[_songId]['artist'];
    }
    return "";
  }

  String getTitle() {
    if (_audioPlayerState == AudioPlayerState.PLAYING ||
        _audioPlayerState == AudioPlayerState.PAUSED) {
      return _songsData[_songId]['title'];
    }
    return "";
  }

  String getPositionFormatted() {
    String twoDigitSeconds =
        _position.inSeconds.remainder(Duration.secondsPerMinute) >= 10
            ? "${_position.inSeconds.remainder(Duration.secondsPerMinute)}"
            : "0${_position.inSeconds.remainder(Duration.secondsPerMinute)}";
    if (_audioPlayerState == AudioPlayerState.PLAYING ||
        _audioPlayerState == AudioPlayerState.PAUSED) {
      return "${_position.inMinutes}:$twoDigitSeconds";
    }
    return "";
  }

  String getDurationFormatted() {
    String twoDigitSeconds =
        _duration.inSeconds.remainder(Duration.secondsPerMinute) >= 10
            ? "${_duration.inSeconds.remainder(Duration.secondsPerMinute)}"
            : "0${_duration.inSeconds.remainder(Duration.secondsPerMinute)}";
    if (_audioPlayerState == AudioPlayerState.PLAYING ||
        _audioPlayerState == AudioPlayerState.PAUSED) {
      return "${_duration.inMinutes}:$twoDigitSeconds";
    }
    return "";
  }

  Map<String, String> getSongData([songId]) {
    return _songsData[songId ?? _songId];
  }

  void play([songId]) {
    _songId = songId ?? _songId ?? 0;
    audioCache.play(_songsData[_songId]['file']);
  }

  void pause() {
    audioPlayer.pause();
  }

  void seekSecond(int seconds) {
    audioPlayer.seek(Duration(seconds: seconds));
  }

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
