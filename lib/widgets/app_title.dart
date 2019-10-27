import 'package:flutter/material.dart';

import '../styleguide.dart';

class AppTitle extends StatelessWidget {
  final String _title;
  AppTitle(this._title);

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
        _title,
        style: textTitleStyle,
      ),
    );
  }
}
