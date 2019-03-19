import 'package:flutter/material.dart';

class VideoCover extends StatefulWidget {
  String cover;

  VideoCover({Key key, this.cover}) : super(key: key);

  @override
  _VideoCoverState createState() => _VideoCoverState();
}

class _VideoCoverState extends State<VideoCover> with TickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Stack(
        children: <Widget>[
          Image.network(widget.cover, fit: BoxFit.fill),
          Container(
            alignment: Alignment.center,
            child: Container(
              width: 70.0,
              height: 70.0,
              child: IconButton(
                onPressed: () {
                  animationController.forward();
                },
                icon: AnimatedIcon(
                    icon: AnimatedIcons.play_pause,
                    color: Colors.white,
                    progress: animationController,
                    semanticLabel: 'Show menu'),
              ),
              decoration: BoxDecoration(
                  color: Color(0x20000000),
                  borderRadius: BorderRadius.all(Radius.circular(35.0))),
            ),
          ),
        ],
      ),
    );
  }
}
