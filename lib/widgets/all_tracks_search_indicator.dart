import 'package:flutter/material.dart';

import '../dummydata.dart';

class AllTracksSearchIndicator extends StatelessWidget {
  final String letter;

  AllTracksSearchIndicator(this.letter);

  @override
  Widget build(BuildContext context) {
    int position = 0;
    for (int i = 0; i < letters.length; i++) {
      if (letter == letters[i]) {
        position = i;
        break;
      }
    }

    return AnimatedPositioned(
      duration: Duration(
        milliseconds: 100,
      ),
      top: -55 +
          position *
              (MediaQuery.of(context).size.height * .575) /
              letters.length,
      right: 0,
      child: IgnorePointer(
        child: Container(
          child: Row(
            children: <Widget>[
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xCCC56970),
                      Color(0xCCD09d7c),
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 2,
                      spreadRadius: 1,
                    )
                  ],
                ),
                child: Center(
                  child: Text(
                    letter,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 15),
              CustomPaint(
                painter: IndicatorPainter(),
                size: Size(40, 150),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class IndicatorPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    LinearGradient gradient = LinearGradient(
      colors: [
        Color(0xCCC56970),
        Color(0xCCD09d7c),
      ],
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
    );

    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..shader = gradient.createShader(
        Rect.fromPoints(
          Offset(0, 0),
          Offset(
            size.width,
            size.height,
          ),
        ),
      );

    Path path = Path();
    path.moveTo(size.width, size.height);
    path.cubicTo(
      size.width * .8,
      size.height * .75,
      0,
      size.height * .70,
      0,
      size.height / 2,
    );
    path.cubicTo(
      0,
      size.height * .25,
      size.width * .8,
      size.height * .30,
      size.width,
      0,
    );
    path.lineTo(size.width, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
