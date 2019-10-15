import 'package:flutter/material.dart';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class PlayerProvider extends ChangeNotifier {
  static AudioCache _audioCache;
  AudioPlayer _audioPlayer;
  AudioPlayerState _audioPlayerState;
  Duration _duration = Duration();
  Duration _position = Duration();
  int _songId;
  List<Map<String, String>> _songsData = [
    {
      'title': 'Standing on the edge',
      'artist': 'Lav',
      'file': 'Lav_-_standing_on_the_edge.mp3',
      'cover': 'playlist_image_1.jpg',
    },
    {
      'title': 'Hachiko (The Faithtful Dog)',
      'artist': 'The Kyoto',
      'file': 'The_Kyoto_Connection_-_09_-_Hachiko_The_Faithtful_Dog.mp3',
      'cover': 'playlist_image_2.jpg',
    },
    {
      'title': 'I Used to Think.mp3',
      'artist': 'Loveshadow',
      'file': 'Loveshadow_-_I_Used_to_Think.mp3',
      'cover': 'playlist_image_3.jpg',
    },
  ];

  AudioCache get audioCache => _audioCache;

  AudioPlayer get audioPlayer => _audioPlayer;

  AudioPlayerState get audioPlayerState => _audioPlayerState;

  Duration get duration => _duration;

  Duration get position => _position;

  Map<String, String> geSongData([songId]) {
    return _songsData[songId ?? _songId];
  }

  void play(songId) {
    _songId = songId;
    audioCache.play(_songsData[songId]['file']);
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
