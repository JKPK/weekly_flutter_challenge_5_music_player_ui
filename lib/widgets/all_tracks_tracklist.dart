import 'package:flutter/material.dart';

import '../widgets/all_tracks_track.dart';

class AllTracksTrackList extends StatelessWidget {
  final songsData;
  final ScrollController tracklistScrollController;

  AllTracksTrackList(
    this.songsData,
    this.tracklistScrollController,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: SingleChildScrollView(
        controller: tracklistScrollController,
        padding: const EdgeInsets.only(
          left: 30.0,
          right: 42.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            for (var songData in songsData)
              AllTracksTrack(
                title: songData['title'],
                artist: songData['artist'],
                duration: songData['duration'],
                cover: songData['cover'],
              ),
          ],
        ),
      ),
    );
  }
}
