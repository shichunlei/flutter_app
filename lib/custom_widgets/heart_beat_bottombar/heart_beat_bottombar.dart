import 'package:flutter/material.dart';
import 'package:flutter_app/custom_widgets/heart_beat_bottombar/heart_beat_painter.dart';

// https://github.com/Bernardi23/HeartBeatAppBar
class HeartBeatBottomBar extends StatelessWidget {
  HeartBeatBottomBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: <Color>[
          Colors.pink[300].withOpacity(0.7),
          Colors.pink[300],
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(10), topLeft: Radius.circular(10)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.pink[300].withOpacity(0.4),
            blurRadius: 10.0,
            spreadRadius: 5.0,
            offset: Offset(0, 5),
          )
        ],
      ),
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.025),
      width: MediaQuery.of(context).size.width * 0.8,
      height: 70.0,
      child: HeartBeatBottomBarContent(MediaQuery.of(context).size),
    );
  }
}

class HeartBeatBottomBarContent extends StatefulWidget {
  final Size device;

  HeartBeatBottomBarContent(this.device);

  @override
  _HeartBeatBottomBarContentState createState() =>
      _HeartBeatBottomBarContentState();
}

class _HeartBeatBottomBarContentState extends State<HeartBeatBottomBarContent>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _activatingOpacity;
  Animation<double> _deactivatingOpacity;
  Animation<double> _heartBeatAnimation;

  int _activated;
  int _nextActivated;

  List<double> _positions = [0, 0, 0, 0, 0];

  Opacity fadableIcon(IconData icon, int index) {
    if (index == _activated) {
      return Opacity(
        opacity: _deactivatingOpacity.value,
        child: Icon(
          icon,
          color: Colors.white,
        ),
      );
    } else if (index == _nextActivated) {
      return Opacity(
        opacity: _activatingOpacity.value,
        child: Icon(
          icon,
          color: Colors.white,
        ),
      );
    } else {
      return Opacity(
        opacity: 0.5,
        child: Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
      );
    }
  }

  void _startAnimation(int newActivated) {
    if (!_animationController.isAnimating && newActivated != _activated) {
      int animationDuration = 700 + ((newActivated - _activated).abs()) * 100;
      _animationController.duration = Duration(milliseconds: animationDuration);

      setState(() {
        _nextActivated = newActivated;
      });

      _animationController.forward();

      _animationController.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _activated = newActivated;
            _nextActivated = 0;
          });
          _animationController.reset();
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    print(widget.device.width);
    _positions = [
      0,
      widget.device.width * 0.094,
      widget.device.width * 0.284,
      widget.device.width * 0.466,
      widget.device.width * 0.662,
    ];

    _activated = 1;
    _nextActivated = 0;

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (1000 ~/ 2)),
    );

    _deactivatingOpacity = Tween<double>(begin: 1.0, end: 0.5).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          0.0,
          0.5,
          curve: Curves.easeIn,
        ),
      ),
    );

    _activatingOpacity = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          0.5,
          1.0,
          curve: Curves.easeOut,
        ),
      ),
    );

    _heartBeatAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size device = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTapUp: (details) {
                    _startAnimation(1);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: fadableIcon(Icons.home, 1),
                  ),
                ),
                GestureDetector(
                  onTapUp: (details) {
                    _startAnimation(2);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: fadableIcon(Icons.photo, 2),
                  ),
                ),
                GestureDetector(
                  onTapUp: (details) {
                    _startAnimation(3);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: fadableIcon(Icons.view_list, 3),
                  ),
                ),
                GestureDetector(
                  onTapUp: (details) {
                    _startAnimation(4);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: fadableIcon(Icons.person, 4),
                  ),
                ),
              ],
            );
          },
        ),
        CustomPaint(
          size: Size(device.width, 6),
          painter: HeartBeatPainter(
            animation: _heartBeatAnimation,
            beginning: _positions[_activated],
            ending: _positions[_nextActivated],
          ),
        ),
      ],
    );
  }
}
