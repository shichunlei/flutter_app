import 'package:flutter/material.dart';

class AnimatedNumberView extends StatefulWidget {
  final String letter;

  AnimatedNumberView({Key key, this.letter}) : super(key: key);

  @override
  createState() => _AnimatedNumberViewState();
}

class _AnimatedNumberViewState extends State<AnimatedNumberView> with SingleTickerProviderStateMixin {
  AnimationController controller;

  String currentLetter;
  String prevLetter;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    currentLetter = widget.letter;
    prevLetter = widget.letter;
  }

  @override
  void didUpdateWidget(AnimatedNumberView oldWidget) {
    if (widget.letter != oldWidget.letter) {
      setState(() {
        prevLetter = oldWidget.letter;
        currentLetter = widget.letter;
        controller
          ..reset()
          ..forward();
      });
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return Container(
              width: 48,
              child: Stack(children: [
                Transform.translate(
                    offset: Offset(0, -controller.value * 50),
                    child: Opacity(
                        opacity: 1 - controller.value,
                        child: Text(prevLetter, style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold)))),
                Transform.translate(
                    offset: Offset(0, 50 - controller.value * 50),
                    child: Opacity(
                        opacity: controller.value,
                        child: Text(currentLetter, style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold))))
              ]));
        });
  }
}
