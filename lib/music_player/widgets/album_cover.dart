import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../page_index.dart';

class AlbumCover extends StatefulWidget {
  final String image;
  final bool isPlaying;

  const AlbumCover({
    Key key,
    @required this.image,
    this.isPlaying,
  }) : super(key: key);

  @override
  createState() => _AlbumCoverState();
}

class _AlbumCoverState extends State<AlbumCover> {
  double _rotation = 0; // 旋转角度

  Timer _timer;

  @override
  void initState() {
    super.initState();
    if (widget.isPlaying) {
      _startRotation();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _stopRotation();
  }

  @override
  void didUpdateWidget(AlbumCover oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isPlaying != widget.isPlaying) {
      if (widget.isPlaying) {
        _startRotation();
      } else {
        _stopRotation();
      }
    }
  }

  void _startRotation() {
    setState(() {
      _rotation = _rotation == 360 ? 1 : _rotation + 1;
    });

    _timer = Timer(Duration(milliseconds: 40), _startRotation);
  }

  void _stopRotation() {
    if (_timer != null) {
      _timer.cancel();
    }
  }

  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          // player disc
          Positioned(
              child: Container(
                padding: EdgeInsets.all(40),
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.black),
                child: Transform.rotate(
                  child: ClipOval(
                    child: ImageLoadView(widget.image),
                  ),
                  angle: math.pi * _rotation / 180,
                ),
                // color: Colors.red,
                height: 261,
                width: 261,
              ),
              top: 100),

          // player needle
          Positioned(
            child: Container(
              child: Transform(
                child: Image.asset('images/player_needle.png'),
                // pause: -30 playing: 0
                transform: Matrix4.identity()
                  ..rotateZ((widget.isPlaying ? 0 : -30) * math.pi / 180),
                origin: Offset(15, 13),
              ),
              // color: Colors.white,
              height: 134,
              padding: EdgeInsets.only(left: 62),
            ),
            top: 20,
            height: 134,
          ),
        ],
        alignment: Alignment.topCenter,
      ),
    );
  }
}
