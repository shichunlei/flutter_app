import 'package:flutter/material.dart';
import 'package:flutter_app/utils/utils.dart';

import 'on_boarding_enter_animation.dart';

class CircleIconButton extends StatelessWidget {
  const CircleIconButton(
      {Key key,
      @required this.onBoardingEnterAnimation,
      this.animatedValue,
      this.icon,
      this.color,
      this.onPressed,
      @required this.tag})
      : assert(tag != null),
        super(key: key);

  final OnBoardingEnterAnimation onBoardingEnterAnimation;
  final double animatedValue;
  final IconData icon;
  final Color color;
  final Function onPressed;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: onBoardingEnterAnimation.fadeTranslation,
      child: Transform(
        alignment: Alignment.center,
        transform:
            Matrix4.translationValues(animatedValue * Utils.height, 0, 0.0),
        child: FloatingActionButton(
          heroTag: tag,
          child: Icon(
            icon,
            color: Colors.white,
          ),
          onPressed: onPressed,
          backgroundColor: color,
        ),
      ),
    );
  }
}
