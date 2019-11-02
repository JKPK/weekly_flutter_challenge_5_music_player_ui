import 'package:flutter/material.dart';

import '../styleguide.dart';
import '../dummydata.dart';
import '../widgets/all_tracks_search.dart';
import '../widgets/all_tracks_title.dart';
import '../widgets/all_tracks_tracklist.dart';
import '../widgets/all_tracks_search_indicator.dart';

class AllTracks extends StatefulWidget {
  final Stream stream;

  AllTracks(this.stream);

  @override
  _AllTracksState createState() => _AllTracksState();
}

class _AllTracksState extends State<AllTracks> {
  static const _songsData = tracklistSongsData;

  ScrollController _tracklistScrollController;
  double _itemSize;
  int _currentItem;
  String _currentLetter = "#";

  @override
  void initState() {
    _tracklistScrollController = ScrollController();
    _tracklistScrollController.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    setCurrentLetter();
  }

  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  setCurrentLetter() {
    setCurrentItem();
    _currentLetter = (_songsData[_currentItem]["artist"]).substring(0, 1);
    if (double.tryParse(_currentLetter) != null) {
      _currentLetter = "#";
    }
    setState(() {});
  }

  setCurrentItem() {
    _currentItem =
        (_tracklistScrollController.offset / _itemSize).floorToDouble().toInt();
  }

  void jumpToItem(String letter) {
    double position = getLetterScrollPosition(letter);
    if (position != null) {
      _tracklistScrollController.animateTo(
        position,
        duration: Duration(milliseconds: 500),
        curve: Curves.decelerate,
      );
    }
  }

  double getLetterScrollPosition(String letter) {
    double position;
    for (int i = 0; i < _songsData.length; i++) {
      if ((double.tryParse(_songsData[i]["artist"].substring(0, 1)) != null) &&
          letter == "#") {
        position = 0;
      } else if (_songsData[i]["artist"].substring(0, 1) == letter) {
        position = i * _itemSize + 1;
        break;
      }
    }
    return position;
  }

  @override
  Widget build(BuildContext context) {
    _itemSize = MediaQuery.of(context).size.height * .125;

    return StreamBuilder(
      stream: widget.stream,
      initialData: 0.0,
      builder: (context, snapshot) {
        return Container(
          decoration: BoxDecoration(
            gradient: secondPageGradient,
          ),
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * (1.4 - snapshot.data),
          ),
          height: MediaQuery.of(context).size.height * .6,
          width: double.infinity,
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              AllTracksTitle(),
              AllTracksTrackList(
                _songsData,
                _tracklistScrollController,
              ),
              AllTracksSearch(
                _currentLetter,
                jumpToItem,
              ),
              AllTracksSearchIndicator(_currentLetter),
            ],
          ),
        );
      },
    );
  }
}
