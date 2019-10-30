import 'package:flutter/material.dart';

import '../styleguide.dart';

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
