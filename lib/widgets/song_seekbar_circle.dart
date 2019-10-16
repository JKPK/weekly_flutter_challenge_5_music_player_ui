import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../styleguide.dart';
import '../providers/player_provider.dart';

class SongSeekbarCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: MediaQuery.of(context).size.height * .01,
            child: Consumer<PlayerProvider>(
              builder: (context, notifier, child) {
                return Text(
                  notifier.getPositionFormatted(),
                  style: TextStyle(
                    color: textLightColor,
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * .01,
            right: 0,
            child: Consumer<PlayerProvider>(
              builder: (context, notifier, child) {
                return Text(
                  notifier.getDurationFormatted(),
                  style: TextStyle(
                    color: textLightColor,
                  ),
                );
              },
            ),
          ),
          CustomPaint(
            painter: SeekbarPainter(),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.height * .075,
                height: MediaQuery.of(context).size.height * .075,
                decoration: BoxDecoration(
                  color: Color(0xFFfbbb8a),
                  gradient: RadialGradient(
                    colors: [
                      Color(0xFFffd390),
                      Color(0xFFfbbb8a),
                    ],
                    center: Alignment(-0.2, -0.2),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 10,
                    ),
                  ],
                  shape: BoxShape.circle,
                ),
                child: GestureDetector(
                  onTap: () {
                    if (Provider.of<PlayerProvider>(context, listen: false)
                        .isPlaying) {
                      Provider.of<PlayerProvider>(context, listen: false)
                          .pause();
                    } else {
                      Provider.of<PlayerProvider>(context, listen: false)
                          .play();
                    }
                  },
                  child: Container(
                    child: Center(
                      child: PlayPauseButton(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PlayPauseButton extends StatefulWidget {
  _PlayPauseButtonState createState() => _PlayPauseButtonState();
}

class _PlayPauseButtonState extends State<PlayPauseButton>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  bool _isPlaying = false;

  @override
  void initState() {
    _animationController = AnimationController(
        duration: Duration(
          milliseconds: 400,
        ),
        vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<PlayerProvider>(context).addListener(() {
      if (Provider.of<PlayerProvider>(context, listen: false).isPlaying) {
        _animationController.forward();
        _isPlaying = true;
      } else {
        _animationController.reverse();
        _isPlaying = false;
      }
    });
    return AnimatedIcon(
      icon: AnimatedIcons.play_pause,
      progress: _animationController,
      color: Colors.black,
      size: 38,
    );
  }
}

class SeekbarPainter extends CustomPainter {
  double radius;
  final double margin = .03;

  void paint(Canvas canvas, Size size) {
    radius = math.min(size.width, size.height) / 2;

    paintBackground(canvas, size);
    paintOuterLine(canvas, size);
  }

  void paintOuterLine(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = .8
      ..color = textLightColor
      ..style = PaintingStyle.stroke;

    canvas.drawArc(
      Rect.fromLTRB(
        radius * 2 * margin,
        radius * 2 * margin,
        radius * 2 * (1 - margin),
        radius * 2 * (1 - margin),
      ),
      math.pi * .75,
      math.pi * 1.5,
      false,
      paint,
    );

    paint.style = PaintingStyle.fill;
    canvas.drawCircle(
        Offset(
          size.width * (1 - margin * 5.6),
          size.width * (1 - margin * 5.6),
        ),
        2,
        paint);
    canvas.drawCircle(
        Offset(
          size.width * (margin * 5.6),
          size.width * (1 - margin * 5.6),
        ),
        2,
        paint);
  }

  void paintBackground(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = textLightColor.withOpacity(0.1);

    canvas.drawCircle(
      Offset(radius, radius),
      radius * (1 - margin * 2),
      paint,
    );
  }

  bool shouldRepaint(SeekbarPainter oldDelegate) {
    return true;
  }
}
