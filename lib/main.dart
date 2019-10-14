import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'pages/player_page.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Ubuntu",
      ),
      title: "Weekly Flutter Challenge 5",
      debugShowCheckedModeBanner: false,
      home: PlayerPage(),
    );
  }
}
