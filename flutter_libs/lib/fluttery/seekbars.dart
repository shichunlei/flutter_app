import 'dart:math' show min, pi, cos, sin;

import 'package:flutter/material.dart' show Colors;
import 'package:flutter/widgets.dart';

import 'src/radial_drag_gesture_detector.dart';

// TODO: support CW and CCW
// TODO: support arbitrary number of radial painters
// TODO: unify margin type between seek bar and progress bar

/// A seek bar that is drawn as a circle, which the user drags radially.
///
/// [RadialSeekBar] is essentially a [RadialProgressBar] with drag
/// support built on top.
///
/// See also:
///  * [RadialProgressBar], which provides the visual behavior for
///     a [RadialSeekBar]
class RadialSeekBar extends StatefulWidget {
  static const Color defaultTrackColor = const Color(0xFFCCCCCC);
  static const Color defaultSeekColor = const Color(0xFF888888);
  static const Color defaultProgressColor = Colors.black;
  static const Color defaultThumbColor = Colors.black;

  RadialSeekBar({
    this.margin = 0.0,
    this.trackWidth = 1.0,
    this.trackColor = defaultTrackColor,
    this.seekWidth = 2.0,
    this.seekColor = defaultSeekColor,
    this.seekPercent = 0.0,
    this.progressWidth = 2.0,
    this.progressColor = defaultProgressColor,
    this.progress = 0.0,
    this.thumb,
    this.thumbPercent = 0.0,
    this.centerContent,
    this.onDragStart,
    this.onDragUpdate,
    this.onDragEnd,
  });

  /// {@macro radial_bar_margin}
  final double margin;

  /// {@macro radial_bar_trackWidth}
  final double trackWidth;

  /// {@macro radial_bar_trackColor}
  final Color trackColor;

  /// {@macro radial_bar_seekWidth}
  final double seekWidth;

  /// {@macro radial_bar_seekColor}
  final Color seekColor;

  /// {@macro radial_bar_seekPercent}
  final double seekPercent;

  /// {@macro radial_bar_progressWidth}
  final double progressWidth;

  /// {@macro radial_bar_progressColor}
  final Color progressColor;

  /// {@macro radial_bar_progressPercent}
  final double progress;

  /// {@macro radial_bar_thumb}
  final Widget thumb;

  /// {@macro radial_bar_thumbPercent}
  /// TODO: don't ignore this value while the user is dragging - always defer to it for painting
  final double thumbPercent;

  /// {@macro radial_bar_centerContent}
  final Widget centerContent;

  /// Hook invoked when the user starts dragging radially.
  ///
  /// The [percent] represents a radial position in [0.0, 1.0).
  final Function(double percent) onDragStart;

  /// Hook invoked when the user has dragged some amount radially.
  ///
  /// The [percent] represents a radial position in [0.0, 1.0).
  final Function(double percent) onDragUpdate;

  /// Hook invoked when the user stops dragging radially.
  ///
  /// The [percent] represents a radial position in [0.0, 1.0).
  final Function(double percent) onDragEnd;

  @override
  RadialSeekBarState createState() {
    return new RadialSeekBarState();
  }
}

class RadialSeekBarState extends State<RadialSeekBar> {
  double _thumbPercent = 0.0;
  PolarCoord _startDragCoord;
  double _currentDragPercent;

  @override
  void initState() {
    super.initState();
    _thumbPercent = widget.thumbPercent;
  }

  @override
  void didUpdateWidget(RadialSeekBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update the thumb position percent if user is not currently dragging.
    if (_startDragCoord == null) {
      _thumbPercent = widget.thumbPercent;
    }
  }

  void _onDragStart(PolarCoord coord) {
    _startDragCoord = coord;

    if (widget.onDragStart != null) {
      widget.onDragStart(_thumbPercent);
    }
  }

  void _onDragUpdate(PolarCoord coord) {
    final double dragAngle = coord.angle - _startDragCoord.angle;
    final double dragPercent = dragAngle / (2 * pi);
    _currentDragPercent = (_thumbPercent + dragPercent) % 1.0;

    if (widget.onDragUpdate != null) {
      widget.onDragUpdate(_currentDragPercent);
    }
  }

  void _onDragEnd() {
    if (widget.onDragEnd != null) {
      widget.onDragEnd(_currentDragPercent);
    }

    _thumbPercent = _currentDragPercent;
    _startDragCoord = null;
    _currentDragPercent = null;
  }

  @override
  Widget build(BuildContext context) {
    double thumbPosition = widget.thumbPercent;
    if (_currentDragPercent != null) {
      thumbPosition = _currentDragPercent;
    }

    return RadialDragGestureDetector(
      onRadialDragStart: _onDragStart,
      onRadialDragUpdate: _onDragUpdate,
      onRadialDragEnd: _onDragEnd,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.transparent,
        child: Center(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: RadialProgressBar(
              margin: EdgeInsets.all(widget.margin),
              trackColor: widget.trackColor,
              trackWidth: widget.trackWidth,
              seekColor: widget.seekColor,
              seekWidth: widget.seekWidth,
              seekPercent: widget.seekPercent,
              progressPercent: widget.progress,
              progressColor: widget.progressColor,
              progressWidth: widget.progressWidth,
              thumb: widget.thumb,
              thumbPosition: thumbPosition,
              centerContent: widget.centerContent,
            ),
          ),
        ),
      ),
    );
  }
}

/// A progress bar that is drawn as a circle.
///
/// [RadialProgressBar] supports centered content, a track, a seek ring,
/// a progress ring, and a thumb, drawn in that order from bottom to top.
///
/// See also:
///  * [RadialSeekBar], which adds drag support to a [RadialProgressBar].
class RadialProgressBar extends StatefulWidget {
  RadialProgressBar({
    this.margin = const EdgeInsets.all(0.0),
    this.trackWidth = 3.0,
    this.trackColor = Colors.grey,
    this.seekWidth = 5.0,
    this.seekColor = const Color(0xFFEEEEEE),
    this.seekPercent = 0.0,
    this.progressWidth = 5.0,
    this.progressColor = Colors.black,
    this.progressPercent = 0.0,
    this.thumb,
    this.thumbPosition = 0.0,
    this.centerContent,
  });

  /// {@template radial_bar_margin}
  /// Whitespace added around all sides of the track.
  /// {@endtemplate}
  final EdgeInsets margin;

  /// {@template radial_bar_trackWidth}
  /// The thickness of the track.
  /// {@endtemplate}
  final double trackWidth;

  /// {@template radial_bar_trackColor}
  /// The color of the track.
  /// {@endtemplate}
  final Color trackColor;

  /// {@template radial_bar_seekWidth}
  /// The thickness of the seek ring.
  /// {@endtemplate}
  final double seekWidth;

  /// {@template radial_bar_seekColor}
  /// The color of the seek ring.
  /// {@endtemplate}
  final Color seekColor;

  /// {@template radial_bar_seekPercent}
  /// The percentage of the seek ring to paint.
  /// {@endtemplate}
  final double seekPercent;

  /// {@template radial_bar_progressWidth}
  /// The thickness of the progress ring.
  /// {@endtemplate}
  final double progressWidth;

  /// {@template radial_bar_progressColor}
  /// The color of the progress ring.
  /// {@endtemplaet}
  final Color progressColor;

  /// {@template radial_bar_progressPercent}
  /// The percentage of the progress ring to paint.
  /// {@endtemplate}
  final double progressPercent;

  /// {@template radial_bar_thumb}
  /// The visual representation of the draggable thumb.
  /// {@endtemplate}
  final Widget thumb;

  /// {@template radial_bar_thumbPosition}
  /// The current percent position of the draggable thumb.
  /// {@endtemplate}
  /// TODO: don't ignore this value while the user is dragging - always defer to it for painting
  final double thumbPosition;

  /// {@template radial_bar_centerContent}
  /// The (optional) content at the center of this [RadialSeekBar].
  /// {@endtemplate}
  final Widget centerContent;

  @override
  _RadialProgressBarState createState() => new _RadialProgressBarState();
}

class _RadialProgressBarState extends State<RadialProgressBar> {
  @override
  Widget build(BuildContext context) {
    // TODO: use thumb widget if provided.
    return Center(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Padding(
          padding: widget.margin,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              CustomPaint(
                foregroundPainter: RadialSeekBarPainter(
                  trackWidth: widget.trackWidth,
                  trackColor: widget.trackColor,
                  seekWidth: widget.seekWidth,
                  seekColor: widget.seekColor,
                  seekPercent: widget.seekPercent,
                  progressWidth: widget.progressWidth,
                  progressColor: widget.progressColor,
                  progressPercent: widget.progressPercent,
                ),
                child: ClipOval(
                  clipper: CircleClipper(),
                  child: widget.centerContent,
                ),
              ),
              LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    final size = min(constraints.maxWidth, constraints.maxHeight);
                    final Offset center =
                    Offset(constraints.maxWidth / 2, constraints.maxHeight / 2);
                    final double radius = size / 2;
                    final thumbAngle = 2 * pi * widget.thumbPosition - (pi / 2);
                    final Offset thumbRelativeCenter = Offset(
                      cos(thumbAngle) * radius,
                      sin(thumbAngle) * radius,
                    );
                    final Offset thumbAbsoluteCenter = center + thumbRelativeCenter;

                    return Transform(
                      transform: Matrix4.translationValues(
                        thumbAbsoluteCenter.dx,
                        thumbAbsoluteCenter.dy,
                        0.0,
                      ),
                      child: FractionalTranslation(
                        translation: const Offset(-0.5, -0.5),
                        child: Center(
                          child: widget.thumb ?? SizedBox(),
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class CircleThumb extends StatelessWidget {
  CircleThumb({
    this.color,
    this.diameter,
  });

  final Color color;
  final double diameter;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}

class RadialSeekBarPainter extends CustomPainter {
  RadialSeekBarPainter({
    @required this.trackWidth,
    @required trackColor,
    @required this.seekWidth,
    @required seekColor,
    @required this.seekPercent,
    @required this.progressWidth,
    @required progressColor,
    @required this.progressPercent,
  })  : trackPaint = new Paint()
    ..color = trackColor
    ..style = PaintingStyle.stroke
    ..strokeWidth = trackWidth,
        seekPaint = new Paint()
          ..color = seekColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = seekWidth
          ..strokeCap = StrokeCap.round,
        progressPaint = new Paint()
          ..color = progressColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = progressWidth
          ..strokeCap = StrokeCap.round;

  final double trackWidth;
  final Paint trackPaint;
  final double seekWidth;
  final Paint seekPaint;
  final double seekPercent;
  final double progressWidth;
  final Paint progressPaint;
  final double progressPercent;

  @override
  void paint(Canvas canvas, Size size) {
//    final outerThickness = marginFit == MarginFit.fitAll
//        ? max(trackWidth, max(progressWidth, thumbDiameter))
//        : max(trackWidth, progressWidth);
//
//    Size constrainedSize = new Size(
//      size.width - outerThickness,
//      size.height - outerThickness,
//    );
    Size constrainedSize = size;

    final center = new Offset(size.width / 2, size.height / 2);
    final radius = min(constrainedSize.width, constrainedSize.height) / 2;

    // Paint track.
    if (trackWidth > 0.0) {
      canvas.drawCircle(
        center,
        radius,
        trackPaint,
      );
    }

    // Paint seek.
    if (seekWidth > 0.0) {
      final seekAngle =
          2 * pi * (seekPercent >= 0.0 ? seekPercent : seekPercent + 1);
      canvas.drawArc(
        new Rect.fromCircle(
          center: center,
          radius: radius,
        ),
        -pi / 2,
        seekAngle,
        false,
        seekPaint,
      );
    }

    // Paint progress.
    if (progressWidth > 0.0) {
      final progressAngle = 2 *
          pi *
          (progressPercent >= 0.0 ? progressPercent : progressPercent + 1);
      canvas.drawArc(
        new Rect.fromCircle(
          center: center,
          radius: radius,
        ),
        -pi / 2,
        progressAngle,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(RadialSeekBarPainter old) {
    return trackWidth != old.trackWidth ||
        trackPaint.color != old.trackPaint.color ||
        seekWidth != old.seekWidth ||
        seekPaint.color != old.seekPaint.color ||
        seekPercent != old.seekPercent ||
        progressWidth != old.progressWidth ||
        progressPaint.color != old.progressPaint.color ||
        progressPercent != old.progressPercent;
  }
}

class CircleClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return new Rect.fromCircle(
      center: new Offset(size.width / 2, size.height / 2),
      radius: min(size.width, size.height) / 2,
    );
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return false;
  }
}
