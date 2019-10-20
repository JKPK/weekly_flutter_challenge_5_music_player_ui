import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../styleguide.dart';

class PlayerVisualizer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * .275,
        left: MediaQuery.of(context).size.width * .05,
        right: MediaQuery.of(context).size.width * .05,
      ),
      height: MediaQuery.of(context).size.height * .2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          for (int i = 0; i < 23; i++) VisualizerBar(math.Random().nextInt(14)),
        ],
      ),
    );
  }
}

class VisualizerBar extends StatelessWidget {
  final _activeTiles;

  VisualizerBar(this._activeTiles);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .9 / 25,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            for (int i = 13; i > 0; i--)
              VisualizerTile(TilePosition.top, _activeTiles >= i),
            for (int i = 1; i <= 13; i++)
              VisualizerTile(TilePosition.bottom, _activeTiles >= i),
          ],
        ),
      ),
    );
  }
}

class VisualizerTile extends StatelessWidget {
  final TilePosition _tilePosition;
  final bool _isActive;

  VisualizerTile(
    this._tilePosition,
    this._isActive,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _isActive
          ? (_tilePosition == TilePosition.top ? tileColorTop : tileColorBottom)
          : Colors.transparent,
      height: MediaQuery.of(context).size.height * .275 / 52,
      child: null,
    );
  }
}

enum TilePosition { top, bottom }
