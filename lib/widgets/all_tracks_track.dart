import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../styleguide.dart';

class AllTracksTrack extends StatefulWidget {
  final String title;
  final String artist;
  final String duration;
  final String cover;

  AllTracksTrack({
    this.title,
    this.artist,
    this.duration,
    this.cover,
  });

  @override
  _AllTracksTrackState createState() => _AllTracksTrackState();
}

class _AllTracksTrackState extends State<AllTracksTrack> {
  List<Widget> tracks = [];

  @override
  void initState() {
    for (var i = 0; i < 14; i++) {
      tracks.add(VisualizerTrack(
        math.Random().nextInt(14),
        math.min(0.5, i / 30),
      ));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: borderLightColor.withOpacity(0.5),
            width: 0.2,
          ),
          bottom: BorderSide(
            color: borderLightColor.withOpacity(0.5),
            width: 0.2,
          ),
        ),
      ),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .125,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * .03,
                left: MediaQuery.of(context).size.width * .35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: tracks,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              width: MediaQuery.of(context).size.height * .1,
              height: MediaQuery.of(context).size.height * .1,
              child: Image(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/${widget.cover}"),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.height * .12,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.title,
                  style: TextStyle(
                    color: textLightColor,
                    fontSize: 17,
                  ),
                ),
                SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    Text(
                      widget.artist,
                      style: TextStyle(
                        color: textLightColor,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: textLightColor,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      widget.duration,
                      style: TextStyle(
                        color: textLightColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class VisualizerTrack extends StatelessWidget {
  final _activeTiles;
  final double _opacity;

  VisualizerTrack(this._activeTiles, this._opacity);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .025,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            for (int i = 13; i > 0; i--)
              VisualizerTrackTile(_activeTiles >= i, _opacity),
          ],
        ),
      ),
    );
  }
}

class VisualizerTrackTile extends StatelessWidget {
  final bool _isActive;
  final double _opacity;

  VisualizerTrackTile(
    this._isActive,
    this._opacity,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _isActive
          ? tileColorBottom.withOpacity(_opacity)
          : Colors.transparent,
      height: MediaQuery.of(context).size.height * .275 / 52,
      child: null,
    );
  }
}
