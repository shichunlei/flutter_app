import 'package:flutter/material.dart';
import 'dart:math';

/// https://github.com/Timoteohss/slide_button/blob/master/lib/slide_button.dart

enum SlideButtonDirection { RIGHT, LEFT }

enum SlideButtonState { NOT_CONFIRMED, CONFIRMED }

class SlideButton extends StatefulWidget {
  /// A child, allowing for any widget to
  /// be put inside the background bar
  final Widget backgroundChild;

  /// A child, allowing for any widget to
  /// be put inside the sliding bar
  final Widget slidingChild;

  /// The height of this widget
  final double height;

  /// Background color of this widget
  final Color backgroundColor;

  /// BorderRadius for the sliding bar, default is 50
  final double borderRadius;

  /// Sliding bar color of this widget
  final Color slidingBarColor;

  /// The percentage the bar must be to the button be confirmed.
  /// defaults to 0.9
  final double confirmPercentage;

  /// This updates the borders when the button reaches 0.9
  /// percent dragged, and set the borderRadius to zero,
  /// giving the impression of a "closed" button
  final bool shouldCloseBorders;

  /// The percentage the bar is set to snap when the user is not dragging
  /// Doubles as the initial value for the bar
  final double initialSliderPercentage;

  /// Allows toggling of the draggability of the Button.
  /// Set this to false to prevent the user from being able to drag
  /// the panel up and down. Defaults to true.
  final bool isDraggable;

  /// If non-null, this callback
  /// is called as the button slides around with the
  /// current position of the panel. The position is a double
  /// between initialSliderPercentage and 1.0
  final void Function(double position) onButtonSlide;

  /// If non-null, this callback is called when the
  /// button is CONFIRMED
  final VoidCallback onButtonOpened;

  /// If non-null, this callback is called when the button
  /// is NOT CONFIRMED
  final VoidCallback onButtonClosed;

  /// Either SlideDirection.LEFT or SlideDirection.RIGHT. Indicates which way
  /// the button need to be slided. Defaults to RIGHT. If set to LEFT, the panel attaches
  /// itself to the right of the screen and is confirmed .
  final SlideButtonDirection slideDirection;

  const SlideButton({
    Key key,
    this.slidingChild,
    this.backgroundChild,
    this.height,
    this.confirmPercentage = 0.9,
    this.initialSliderPercentage = 0.2,
    this.slideDirection = SlideButtonDirection.RIGHT,
    this.isDraggable = true,
    this.onButtonSlide,
    this.onButtonOpened,
    this.onButtonClosed,
    @required this.backgroundColor,
    @required this.slidingBarColor,
    this.shouldCloseBorders = true,
    this.borderRadius = 50.0,
  }) : super(key: key);

  @override
  createState() => _SlideButtonState();
}

class _SlideButtonState extends State<SlideButton>
    with SingleTickerProviderStateMixin {
  AnimationController _slideAC;

  var _borderRadius = 0.0;
  var _maxWidth = 0.0;

  @override
  void initState() {
    super.initState();

    _borderRadius = widget.borderRadius;

    _slideAC = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300))
      ..addListener(() {
        setState(() {});

        if (widget.shouldCloseBorders)
          _borderRadius = widget.borderRadius -
              (sigmoid(_slideAC.value) * widget.borderRadius);

        if (widget.onButtonSlide != null) widget.onButtonSlide(_slideAC.value);

        if (widget.onButtonOpened != null && _slideAC.value == 1.0)
          widget.onButtonOpened();

        if (widget.onButtonClosed != null &&
            _slideAC.value == widget.initialSliderPercentage)
          widget.onButtonClosed();
      });

    _slideAC.value = widget.initialSliderPercentage;
  }

  @override
  void dispose() {
    _slideAC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      _maxWidth = constraints.maxWidth;

      return Stack(
        children: <Widget>[
          Align(
            alignment: Alignment(-1.0, 0.0),
            child: Container(
              height: widget.height,
              color: widget.backgroundColor,
              child: widget.backgroundChild ?? null,
            ),
          ),
          Align(
            alignment: Alignment(-1.0, 0.0),
            child: GestureDetector(
              onVerticalDragUpdate: widget.isDraggable ? _onDrag : null,
              onVerticalDragEnd: widget.isDraggable ? _onDragEnd : null,
              child: Container(
                height: widget.height,
                child: Align(
                  alignment: widget.slideDirection == SlideButtonDirection.RIGHT
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: FractionallySizedBox(
                    widthFactor: _slideAC.value,
                    heightFactor: 1.0,
                    child: Container(
                      decoration: BoxDecoration(
                          color: widget.slidingBarColor,
                          borderRadius: widget.slideDirection ==
                                  SlideButtonDirection.RIGHT
                              ? BorderRadius.only(
                                  bottomRight: Radius.circular(_borderRadius),
                                  topRight: Radius.circular(_borderRadius))
                              : BorderRadius.only(
                                  bottomLeft: Radius.circular(_borderRadius),
                                  topLeft: Radius.circular(_borderRadius))),
                      child: widget.slidingChild ?? null,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      );
    });
  }

  // Temporary sigmoid function to remove borders from the sliding bar
  double sigmoid(double x) {
    return 1 / (1 + exp(-61 * x + 54));
  }

  void _onDrag(DragUpdateDetails details) {
    if (widget.slideDirection == SlideButtonDirection.RIGHT) {
      _slideAC.value = (details.globalPosition.dx) / _maxWidth;
    } else {
      _slideAC.value = 1.0 - (details.globalPosition.dx) / _maxWidth;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    if (_slideAC.isAnimating) return;

    if (_slideAC.value > widget.confirmPercentage) {
      _slideAC.fling(velocity: 1.0);
    } else {
      _slideAC.animateTo(widget.initialSliderPercentage,
          duration: Duration(milliseconds: 300), curve: Curves.fastOutSlowIn);
    }
  }
}
