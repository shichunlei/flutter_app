import 'package:flutter/material.dart';

class QuestionTest extends StatefulWidget {
  final String _question;
  final int _questionNumber;

  QuestionTest(this._question, this._questionNumber);

  @override
  _QuestionTestState createState() => _QuestionTestState();
}

class _QuestionTestState extends State<QuestionTest>
    with SingleTickerProviderStateMixin {
  Animation<double> _fontSizeAnimation;
  AnimationController _fontSizeAnimationController;

  @override
  void initState() {
    super.initState();
    _fontSizeAnimationController = AnimationController(
      vsync: this,

      /// 动画时长
      duration: Duration(
        milliseconds: 500,
      ),
    );

    _fontSizeAnimation = CurvedAnimation(
      parent: _fontSizeAnimationController,
      curve: Curves.bounceOut,
    );

    _fontSizeAnimation.addListener(() => this.setState(() {}));

    _fontSizeAnimationController.forward();
  }

  @override
  void dispose() {
    _fontSizeAnimationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(QuestionTest oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget._question != widget._question) {
      _fontSizeAnimationController.reset();
      _fontSizeAnimationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20.0, // 垂直高度Padding
        ),
        child: Center(
          child: Text(
            "Statement ${widget._questionNumber}: ${widget._question}",
            style: TextStyle(fontSize: _fontSizeAnimation.value * 15),
          ),
        ),
      ),
    );
  }
}
