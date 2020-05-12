import 'package:flutter/material.dart';

class AnimatedWear extends AnimatedWidget {
  final bool isStart;
  static final _opacityTween = Tween<double>(begin: 0.5, end: 0);
  static final _sizeTween = Tween<double>(begin: 90, end: 260);

  final double size;

  AnimatedWear({
    Key key,
    this.isStart,
    Animation<double> animation,
    this.size: 70.0,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Container(
        height: 90,
        width: 90,
        child: Stack(
            overflow: Overflow.visible,
            alignment: Alignment.center,
            children: <Widget>[
              Visibility(
                  visible: isStart,
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black.withAlpha(30),
                          borderRadius: BorderRadius.circular(45)))),
              Container(
                  height: size,
                  width: size,
                  decoration:
                      BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                  child: Icon(Icons.mic, color: Colors.white, size: 30)),
              Positioned(
                  left: -((_sizeTween.evaluate(animation) - 90) / 2), //45
                  top: -((_sizeTween.evaluate(animation) - 90) / 2), //45,
                  child: Opacity(
                      opacity: _opacityTween.evaluate(animation),
                      child: Container(
                          width: isStart ? _sizeTween.evaluate(animation) : 0,
                          height: _sizeTween.evaluate(animation),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              shape: BoxShape.circle,
                              border: Border.all(color: Color(0xa8000000))))))
            ]));
  }
}

class AnimatedWearDemo extends StatefulWidget {
  const AnimatedWearDemo({Key key}) : super(key: key);

  @override
  createState() => _AnimatedWearDemoState();
}

class _AnimatedWearDemoState extends State<AnimatedWearDemo>
    with SingleTickerProviderStateMixin {
  String speakTips = '长按说话';

  bool isStart = false;
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));

    animation = CurvedAnimation(parent: controller, curve: Curves.easeInCubic)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reset();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(title: Text('AnimatedWear')),
        body: GestureDetector(
            onTapDown: (e) {
              _speakStart();
            },
            onTapUp: (e) {
              _speakStop();
            },
            onTapCancel: () {
              _speakStop();
            },
            child: Container(
                alignment: Alignment.center,
                height: double.infinity,
                width: double.infinity,
                child: Column(children: <Widget>[
                  Text(speakTips,
                      style: TextStyle(color: Colors.blue, fontSize: 12)),
                  AnimatedWear(animation: animation, isStart: isStart)
                ], mainAxisSize: MainAxisSize.min))));
  }

  _speakStart() {
    controller.forward();
    setState(() {
      speakTips = '松开完成';
      isStart = true;
    });
  }

  _speakStop() {
    setState(() {
      speakTips = '长按说话';
      isStart = false;
    });
    controller.reset();
    controller.stop();
  }
}
