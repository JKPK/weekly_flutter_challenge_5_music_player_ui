import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../styleguide.dart';
import '../providers/player_provider.dart';

class SongSeekbarCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double progress = Provider.of<PlayerProvider>(context, listen: false)
            .position
            .inMilliseconds /
        Provider.of<PlayerProvider>(context, listen: false)
            .duration
            .inMilliseconds;

    if (progress.isNaN) {
      progress = 0.0;
    }

    return Center(
      child: Container(
        width: MediaQuery.of(context).size.height * .25,
        height: MediaQuery.of(context).size.height * .25,
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
              painter: SeekbarPainter(progress),
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
  final double margin = .03;
  final double progressPercent;
  double radius;
  Rect mainRect;

  SeekbarPainter(this.progressPercent);

  void paint(Canvas canvas, Size size) {
    radius = math.min(size.width, size.height) / 2;

    mainRect = Rect.fromLTRB(
      radius * 2 * margin,
      radius * 2 * margin,
      radius * 2 * (1 - margin),
      radius * 2 * (1 - margin),
    );

    paintBackground(canvas, size);
    paintOuterLine(canvas, size);
    paintProgressArc(canvas, size);
  }

  void paintOuterLine(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = .8
      ..color = textLightColor
      ..style = PaintingStyle.stroke;

    canvas.drawArc(
      mainRect,
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
      paint,
    );
    canvas.drawCircle(
      Offset(
        size.width * (margin * 5.6),
        size.width * (1 - margin * 5.6),
      ),
      2,
      paint,
    );
  }

  void paintProgressArc(Canvas canvas, Size size) {
    if (progressPercent == double.nan) {
      return;
    }

    double filledArcAngle = math.pi * 1.5 * progressPercent;
    if (filledArcAngle > math.pi * .25) {
      filledArcAngle = math.pi * .25;
    }

    double progressBallPosX = size.width / 2 +
        (radius - 100 * margin * 2) *
            math.cos(math.pi * .7501 + math.pi * 1.5 * progressPercent);
    double progressBallPosY = size.width / 2 +
        (radius - 100 * margin * 2) *
            math.sin(math.pi * .7501 + math.pi * 1.5 * progressPercent);

    final Gradient gradientProgressBar = new SweepGradient(
      center: Alignment.center,
      colors: [
        Color(0xFFEF787D),
        Color(0xFFFFD08E),
      ],
      startAngle: math.pi * .25,
      endAngle: math.pi * .2501 + math.pi * 1.5 * progressPercent,
    );

    final Paint paintProgressBar = Paint()
      ..shader = gradientProgressBar.createShader(mainRect)
      ..isAntiAlias = true
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final Gradient gradientFilledArc = new SweepGradient(
      center: Alignment.center,
      colors: [
        Colors.transparent,
        Color(0xFFFFD08E).withOpacity(.3),
      ],
      startAngle:
          math.pi * .25 + math.pi * 1.5 * progressPercent - filledArcAngle,
      endAngle: math.pi * .2501 + math.pi * 1.5 * progressPercent,
    );

    final Paint paintFilledArc = Paint()
      ..shader = gradientFilledArc.createShader(mainRect)
      ..isAntiAlias = true;

    final Paint paintBallShadow = Paint()
      ..isAntiAlias = true
      ..color = Colors.black26
      ..style = PaintingStyle.fill;

    final Paint paintBall = Paint()
      ..isAntiAlias = true
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    /* Rotate canvas by 90 degrees to generate gradient with good tiling */
    canvas.save();
    canvas.rotate(math.pi / 2);
    canvas.translate(0, -size.width);
    /* Draw filled arc */
    canvas.drawArc(
      mainRect,
      math.pi * .25 + math.pi * 1.5 * progressPercent - filledArcAngle,
      filledArcAngle,
      true,
      paintFilledArc,
    );
    /* Draw progress bar */
    canvas.drawArc(
      mainRect,
      math.pi * .25,
      math.pi * 1.5 * progressPercent,
      false,
      paintProgressBar,
    );
    canvas.restore();

    /* Draw progress ball shadow */
    canvas.drawCircle(
      Offset(
        progressBallPosX,
        progressBallPosY,
      ),
      9,
      paintBallShadow,
    );

    /* Draw white progress ball */
    canvas.drawCircle(
      Offset(
        progressBallPosX,
        progressBallPosY,
      ),
      7.5,
      paintBall,
    );
  }

  void paintBackground(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = textLightColor.withOpacity(0.075);

    canvas.drawCircle(
      Offset(radius, radius),
      radius * (1 - margin * 2),
      paint,
    );
  }

  bool shouldRepaint(SeekbarPainter oldDelegate) {
    return false;
  }
}
