import 'package:flutter/material.dart';

import '../../page_index.dart';

class RadialSeekBarUI extends StatelessWidget {
  final Function(double percent) onDragStart;
  final Function(double percent) onDragUpdate;
  final Function(double percent) onDragEnd;
  final double thumbPercent;

  final Animation<double> animation;

  final String imageUrl;

  RadialSeekBarUI(
      {Key key,
      this.onDragStart,
      this.thumbPercent,
      this.onDragEnd,
      this.onDragUpdate,
      this.animation,
      this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            width: 200,
            height: 200,
            child: Stack(alignment: Alignment.center, children: <Widget>[
              Container(
                  decoration:
                      BoxDecoration(color: accentColor, shape: BoxShape.circle),
                  child: RadialSeekBar(
                      trackColor: Colors.red.withOpacity(.5),
                      trackWidth: 2.0,
                      progressColor: Color(0xFFFE1483),
                      progressWidth: 5.0,
                      thumbPercent: thumbPercent,
                      thumb:
                          CircleThumb(color: Color(0xFFFE1483), diameter: 15.0),
                      margin: 12.0,
                      progress: thumbPercent,
                      onDragStart: onDragStart,
                      onDragUpdate: onDragUpdate,
                      onDragEnd: onDragEnd)),
              RotationTransition(
                  child: ImageLoadView(
                      imageUrl ??
                          'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1564830238704&di=11798dafaaad4d5f727bac5113ed9ba5&imgtype=0&src=http%3A%2F%2Fpic41.nipic.com%2F20140507%2F7160980_232207178322_2.jpg',
                      shape: BoxShape.circle,
                      width: 150,
                      height: 150),
                  turns: animation)
            ])));
  }
}
