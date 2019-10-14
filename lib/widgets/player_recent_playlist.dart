import 'package:flutter/material.dart';

import '../styleguide.dart';

class PlayerRecentPlaylist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 15,
        ),
        color: backgroundLightColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Recent Playlist",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: textDarkColor,
              ),
            ),
            Divider(
              color: borderColor,
              thickness: 2,
              height: 25,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RecentPlaylistTile(
                  "playlist_image_1.jpg",
                  "Sad But True",
                ),
                RecentPlaylistTile(
                  "playlist_image_2.jpg",
                  "A Thousand Ye...",
                ),
                RecentPlaylistTile(
                  "playlist_image_3.jpg",
                  "Tumi Kothay Ac...",
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class RecentPlaylistTile extends StatelessWidget {
  final String _image;
  final String _title;

  RecentPlaylistTile(
    this._image,
    this._title,
  );

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: borderColor,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image(
                image: AssetImage("assets/images/$_image"),
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
                      "$_title",
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
    );
  }
}
