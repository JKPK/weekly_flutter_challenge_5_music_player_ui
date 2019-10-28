import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../styleguide.dart';
import '../providers/player_provider.dart';

class PlayerRecentPlaylist extends StatelessWidget {
  final String _title;
  final bool _darkMode;

  PlayerRecentPlaylist(
    this._title, [
    this._darkMode = false,
  ]);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .3,
      padding: EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 15,
      ),
      color: _darkMode ? backgroundDarkColor : backgroundLightColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            _title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: _darkMode ? textLightColor : textDarkColor,
            ),
          ),
          Divider(
            color: _darkMode ? borderDarkColor : borderLightColor,
            thickness: 2,
            height: 25,
          ),
          Consumer<PlayerProvider>(
            builder: (context, notifier, child) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RecentPlaylistTile(
                    0,
                    _darkMode,
                  ),
                  RecentPlaylistTile(
                    1,
                    _darkMode,
                  ),
                  RecentPlaylistTile(
                    2,
                    _darkMode,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class RecentPlaylistTile extends StatelessWidget {
  final int _songId;
  final bool _darkMode;

  RecentPlaylistTile(
    this._songId, [
    this._darkMode = false,
  ]);

  @override
  Widget build(BuildContext context) {
    final Map<String, String> songData =
        Provider.of<PlayerProvider>(context, listen: false)
            .getSongData(_songId+(_darkMode?3:0));

    return Expanded(
      child: GestureDetector(
        onTap: () {
          Provider.of<PlayerProvider>(context, listen: false).play(_songId);
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: _darkMode ? backgroundDarkColor : borderLightColor,
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 2,
                  color: Colors.black.withOpacity(0.15),
                  offset: Offset(0, 1),
                )
              ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image(
                    image: AssetImage("assets/images/${songData['cover']}"),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      left: 8,
                      right: 0,
                    ),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "${songData['title'].substring(0, 14)} ...",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: textDarkColor,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.more_vert,
                          size: 15,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
