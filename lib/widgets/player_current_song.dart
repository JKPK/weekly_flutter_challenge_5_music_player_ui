import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../styleguide.dart';
import '../providers/player_provider.dart';
import '../widgets/song_seekbar_circle.dart';
import '../widgets/player_visualizer.dart';

class PlayerCurrentSong extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .7,
      child: Stack(
        children: <Widget>[
          BackgroundSplash(),
          AppTitle(),
          SongHeader(
            Provider.of<PlayerProvider>(context).getTitle(),
            Provider.of<PlayerProvider>(context, listen: false).getArtist(),
            Provider.of<PlayerProvider>(context, listen: false)
                .getDurationFormatted(),
          ),
          PlayerVisualizer(),
          Container(
            height: MediaQuery.of(context).size.width * .5,
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * .25,
              left: MediaQuery.of(context).size.width * .25,
              right: MediaQuery.of(context).size.width * .25,
            ),
            child: SongSeekbarCircle(),
          ),
          CurrentSongButtons(),
          CornerButton(
            icon: Icons.menu,
            corner: CornerPositions.topLeft,
          ),
          CornerButton(
            icon: Icons.search,
            corner: CornerPositions.topRight,
          ),
          CornerButton(
            icon: Icons.fast_rewind,
            corner: CornerPositions.bottomLeft,
            songId: Provider.of<PlayerProvider>(context).songId == 2 ? 1 : 0,
          ),
          CornerButton(
            icon: Icons.fast_forward,
            corner: CornerPositions.bottomRight,
            songId: Provider.of<PlayerProvider>(context).songId == 0 ? 1 : 2,
          ),
        ],
      ),
    );
  }
}

class AppTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 60,
        vertical: 30,
      ),
      height: 35,
      width: double.infinity,
      alignment: Alignment.center,
      child: Text(
        "Music Player",
        style: textTitleStyle,
      ),
    );
  }
}

class SongHeader extends StatelessWidget {
  final String _title;
  final String _artist;
  final String _duration;

  SongHeader(
    this._title,
    this._artist,
    this._duration,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * .15,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "$_title",
            style: TextStyle(
              fontSize: 17,
              color: textLightColor,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "$_artist",
                style: TextStyle(
                  fontWeight: FontWeight.w100,
                  color: textLightColor,
                ),
              ),
              _duration.length > 0
                  ? Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        color: textLightColor,
                        shape: BoxShape.circle,
                      ),
                      width: 4.0,
                      height: 4.0,
                    )
                  : Container(),
              Text(
                "$_duration",
                style: TextStyle(
                  fontWeight: FontWeight.w100,
                  color: textLightColor,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class CurrentSongButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * .24 +
            MediaQuery.of(context).size.width * .5,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * (.7 - .25) -
            MediaQuery.of(context).size.width * .5 -
            30 -
            35,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: () {
                Provider.of<PlayerProvider>(context).seekSecond(0);
              },
              icon: Icon(
                Icons.replay,
                color: textLightColor.withOpacity(.8),
              ),
              padding: EdgeInsets.all(0),
              iconSize: 32,
            ),
            SizedBox(
              width: 10,
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite_border,
                color: textLightColor.withOpacity(.8),
              ),
              padding: EdgeInsets.all(0),
              iconSize: 32,
            ),
            SizedBox(
              width: 10,
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.share,
                color: textLightColor.withOpacity(.8),
              ),
              padding: EdgeInsets.all(0),
              iconSize: 32,
            ),
          ],
        ),
      ),
    );
  }
}

class CornerButton extends StatelessWidget {
  final IconData icon;
  final CornerPositions corner;
  final int songId;

  CornerButton({
    this.icon,
    this.corner,
    this.songId,
  });

  @override
  Widget build(BuildContext context) {
    int currentSongId = Provider.of<PlayerProvider>(context).songId;
    String title = songId != null
        ? Provider.of<PlayerProvider>(context).getSongData(songId)['title']
        : null;
    String artist = songId != null
        ? Provider.of<PlayerProvider>(context).getSongData(songId)['artist']
        : null;
    bool hideElement =
        ((corner == CornerPositions.bottomLeft && currentSongId < 1) ||
            (corner == CornerPositions.bottomRight && currentSongId > 1));

    return Positioned(
      top: (corner == CornerPositions.topLeft ||
              corner == CornerPositions.topRight)
          ? 30
          : null,
      bottom: (corner == CornerPositions.bottomLeft ||
              corner == CornerPositions.bottomRight)
          ? 30
          : null,
      left: (corner == CornerPositions.topLeft ||
              corner == CornerPositions.bottomLeft)
          ? 20
          : null,
      right: (corner == CornerPositions.topRight ||
              corner == CornerPositions.bottomRight)
          ? 20
          : null,
      child: AnimatedOpacity(
        opacity: hideElement ? 0 : 1,
        duration: Duration(milliseconds: 250),
        child: GestureDetector(
          onTap: () {
            if (corner == CornerPositions.bottomRight ||
                corner == CornerPositions.bottomLeft) {
              Provider.of<PlayerProvider>(context, listen: false).play(songId);
            }
          },
          child: Container(
            child: Row(
              children: <Widget>[
                corner == CornerPositions.bottomRight
                    ? CornerButtonLabel(
                        artist: artist,
                        title: title,
                        corner: corner,
                      )
                    : Container(
                        child: null,
                      ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ),
                  width: 35.0,
                  height: 35.0,
                  child: Center(
                    child: Icon(
                      icon,
                      size: 24,
                      color: Colors.white.withOpacity(0.4),
                    ),
                  ),
                ),
                corner == CornerPositions.bottomLeft
                    ? CornerButtonLabel(
                        artist: artist,
                        title: title,
                        corner: corner,
                      )
                    : Container(
                        child: null,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CornerButtonLabel extends StatelessWidget {
  final String artist;
  final String title;
  final CornerPositions corner;

  CornerButtonLabel({
    this.title,
    this.artist,
    this.corner,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: corner == CornerPositions.bottomRight ? 10 : 0,
        left: corner == CornerPositions.bottomLeft ? 10 : 0,
      ),
      child: Column(
        crossAxisAlignment: corner == CornerPositions.bottomRight
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            artist,
            style: TextStyle(
              color: textLightColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            title,
            style: TextStyle(
              color: textLightColor,
              fontSize: 13,
              fontWeight: FontWeight.w100,
            ),
          ),
        ],
      ),
    );
  }
}

class BackgroundSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(MediaQuery.of(context).size.width / 3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: splashColor,
            spreadRadius: MediaQuery.of(context).size.width / 4,
            blurRadius: MediaQuery.of(context).size.width / 4,
          )
        ],
      ),
      child: null,
    );
  }
}

enum CornerPositions {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}
