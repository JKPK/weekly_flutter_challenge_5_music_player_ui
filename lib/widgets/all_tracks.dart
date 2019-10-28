import 'package:flutter/material.dart';

import '../styleguide.dart';

class AllTracks extends StatelessWidget {
  final Stream stream;

  AllTracks(this.stream);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      initialData: 0.0,
      builder: (context, snapshot) {
        print(snapshot.data);
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
              AllTracksTrackList(),
              AllTracksSearch(),
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
  final List<Map<String, String>> _songsData = [
    {
      'title': 'Rap or Go to the League',
      'artist': '2 Chainz',
      'duration': '3:54',
      'cover': 'tracklist_image_1.jpg',
    },
    {
      'title': 'Real Hasta La Muerte 2',
      'artist': 'Anuel AA',
      'duration': '4:07',
      'cover': 'tracklist_image_2.jpg',
    },
    {
      'title': 'thank u, next',
      'artist': 'Ariana Grande',
      'duration': '3:29',
      'cover': 'tracklist_image_3.jpg',
    },
    {
      'title': 'when the party’s over',
      'artist': 'Billie Eilish',
      'duration': '4:25',
      'cover': 'tracklist_image_4.jpg',
    },
    {
      'title': 'Invasion of Privacy',
      'artist': 'Cardi B',
      'duration': '2:43',
      'cover': 'tracklist_image_5.jpg',
    },
    {
      'title': 'No Problem',
      'artist': 'Chance the Rapper',
      'duration': '3:54',
      'cover': 'tracklist_image_6.jpg',
    },
    {
      'title': '2099',
      'artist': 'Charli XCX',
      'duration': '4:07',
      'cover': 'tracklist_image_7.jpg',
    },
    {
      'title': 'This Is America',
      'artist': 'Childish Gambino',
      'duration': '3:29',
      'cover': 'tracklist_image_8.jpg',
    },
    {
      'title': 'Revenge of The Dreamers III',
      'artist': 'Dreamville',
      'duration': '4:25',
      'cover': 'tracklist_image_9.jpg',
    },
    {
      'title': 'New Rules',
      'artist': 'Dua Lipa',
      'duration': '2:43',
      'cover': 'tracklist_image_10.jpg',
    },
    {
      'title': 'Thinking Bout You',
      'artist': 'Frank Ocean',
      'duration': '3:54',
      'cover': 'tracklist_image_11.jpg',
    },
    {
      'title': 'Oblivion',
      'artist': 'Grimes',
      'duration': '3:54',
      'cover': 'tracklist_image_12.jpg',
    },
    {
      'title': 'The Fall Off',
      'artist': 'J. Cole',
      'duration': '4:07',
      'cover': 'tracklist_image13.jpg',
    },
    {
      'title': 'Yandhi',
      'artist': 'Kanye West',
      'duration': '3:29',
      'cover': 'tracklist_image_14.jpg',
    },
    {
      'title': 'Nights Like This,',
      'artist': 'Kehlani',
      'duration': '4:25',
      'cover': 'tracklist_image_15.jpg',
    },
    {
      'title': 'Norman Fucking Rockwell',
      'artist': 'Lana Del Rey',
      'duration': '2:43',
      'cover': 'tracklist_image_16.jpg',
    },
    {
      'title': 'Eternal Atake',
      'artist': 'Lil Uzi Vert',
      'duration': '3:54',
      'cover': 'tracklist_image_17.jpg',
    },
    {
      'title': 'Red Room',
      'artist': 'Offset',
      'duration': '3:54',
      'cover': 'tracklist_image_18.jpg',
    },
    {
      'title': 'Umbrella',
      'artist': 'Rihanna',
      'duration': '4:07',
      'cover': 'tracklist_image_19.jpg',
    },
    {
      'title': 'Run the Jewels 4',
      'artist': 'Run the Jewels',
      'duration': '3:29',
      'cover': 'tracklist_image_20.jpg',
    },
    {
      'title': 'Blank Face',
      'artist': 'ScHoolboy Q',
      'duration': '4:25',
      'cover': 'tracklist_image_21.jpg',
    },
    {
      'title': 'A Seat at the Table',
      'artist': 'Solange',
      'duration': '2:43',
      'cover': 'tracklist_image_22.jpg',
    },
    {
      'title': 'A',
      'artist': 'SZA',
      'duration': '3:54',
      'cover': 'tracklist_image_23.jpg',
    },
    {
      'title': 'Currents',
      'artist': 'Tame Impala',
      'duration': '3:54',
      'cover': 'tracklist_image_24.jpg',
    },
    {
      'title': 'Chapter VI',
      'artist': 'The Weeknd',
      'duration': '4:07',
      'cover': 'tracklist_image_25.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 42.0, top: 30.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            for (var songData in _songsData)
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
  @override
  Widget build(BuildContext context) {
    return Container(
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
            AllTracksSearchLetter("#"),
            AllTracksSearchLetter("A"),
            AllTracksSearchLetter("B"),
            AllTracksSearchLetter("C"),
            AllTracksSearchLetter("D"),
            AllTracksSearchLetter("E"),
            AllTracksSearchLetter("F"),
            AllTracksSearchLetter("G"),
            AllTracksSearchLetter("H"),
            AllTracksSearchLetter("I"),
            AllTracksSearchLetter("J"),
            AllTracksSearchLetter("K"),
            AllTracksSearchLetter("L"),
            AllTracksSearchLetter("M"),
            AllTracksSearchLetter("N"),
            AllTracksSearchLetter("O"),
            AllTracksSearchLetter("P"),
            AllTracksSearchLetter("Q"),
            AllTracksSearchLetter("R"),
            AllTracksSearchLetter("S"),
            AllTracksSearchLetter("T"),
            AllTracksSearchLetter("U"),
            AllTracksSearchLetter("V"),
            AllTracksSearchLetter("W"),
            AllTracksSearchLetter("X"),
            AllTracksSearchLetter("Y"),
            AllTracksSearchLetter("Z"),
          ],
        ),
      ),
    );
  }
}

class AllTracksSearchLetter extends StatelessWidget {
  final String letter;

  AllTracksSearchLetter(this.letter);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        letter,
        style: TextStyle(
          color: textLightColor,
          fontSize: 11,
        ),
      ),
    );
  }
}
