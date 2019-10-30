import 'package:flutter/material.dart';

import '../styleguide.dart';
import '../dummydata.dart';

class AllTracks extends StatefulWidget {
  final Stream stream;

  AllTracks(this.stream);

  @override
  _AllTracksState createState() => _AllTracksState();
}

class _AllTracksState extends State<AllTracks> {
  static const _songsData = songsData;

  ScrollController _tracklistScrollController;
  double _itemSize;
  int _currentItem;
  String _currentLetter;
  bool _isInit = false;

  @override
  void initState() {
    _tracklistScrollController = ScrollController();
    _tracklistScrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      _itemSize = MediaQuery.of(context).size.height * .125;
      _isInit = true;
    }
    super.didChangeDependencies();
  }

  void _scrollListener() {
    setCurrentLetter();
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
      if (_songsData[i]["artist"].substring(0, 1) == letter) {
        position = i * _itemSize;
        break;
      }
    }
    ;
    return position;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.stream,
      initialData: 0.0,
      builder: (context, snapshot) {
        return Container(
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * (1.4 - snapshot.data),
          ),
          height: MediaQuery.of(context).size.height * .6,
          width: double.infinity,
          color: backgroundDarkColor,
          child: Stack(
            children: <Widget>[
              AllTracksTitle(),
              AllTracksTrackList(_songsData, _tracklistScrollController),
              AllTracksSearch(_currentLetter, jumpToItem),
            ],
          ),
        );
      },
    );
  }
}

class AllTracksTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: Text(
        "All Tracks",
        style: TextStyle(color: textLightColor, fontSize: 15),
      ),
    );
  }
}

class AllTracksTrackList extends StatelessWidget {
  final songsData;
  ScrollController tracklistScrollController;

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

class AllTracksTrack extends StatelessWidget {
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
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              width: MediaQuery.of(context).size.height * .1,
              height: MediaQuery.of(context).size.height * .1,
              child: Image(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/$cover"),
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
                  title,
                  style: TextStyle(
                    color: textLightColor,
                    fontSize: 17,
                  ),
                ),
                SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    Text(
                      artist,
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
                      duration,
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

class AllTracksSearch extends StatelessWidget {
  final String currentLetter;
  final Function feedbackFunction;
  static const List<String> letters = [
    "#",
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z",
  ];

  AllTracksSearch(
    this.currentLetter,
    this.feedbackFunction,
  );

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      child: Container(
        height: MediaQuery.of(context).size.height * .6,
        alignment: Alignment.topRight,
        child: Container(
          width: 25,
          margin: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 10.0,
          ),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              const Radius.circular(5.0),
            ),
            border: Border.all(
              color: textLightColor.withOpacity(0.5),
              width: 0.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              for (String letter in letters)
                AllTracksSearchLetter(
                  letter,
                  feedbackFunction,
                  currentLetter == letter,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class AllTracksSearchLetter extends StatelessWidget {
  final String letter;
  final Function feedbackFunction;
  final bool isActive;

  AllTracksSearchLetter(
    this.letter,
    this.feedbackFunction,
    this.isActive,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        feedbackFunction(letter);
      },
      child: Container(
        child: Text(
          letter,
          style: TextStyle(
            color: isActive ? Colors.white : textLightColor,
            fontSize: 11,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
