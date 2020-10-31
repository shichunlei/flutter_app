import 'dart:math' as math;

import 'package:flutter/material.dart';

/// https://github.com/Frezyx/animated_icon_button/blob/master/lib/animated_icon_button.dart

class AnimatedIconButton extends StatefulWidget {
  /// The size of the [AnimatedIconButton].
  final double size;

  /// The icon of the [AnimatedIconButton] when button is not pressed.
  final Icon startIcon;

  /// The icon of the [AnimatedIconButton] when button is pressed.
  final Icon endIcon;

  /// Animation time of the [AnimatedIconButton].
  ///
  /// If an [AnimationController] is specified, [Duration] must be null
  /// in order to prevent an asynchronous animation. The [Duration] used will
  /// be the one defined on [AnimationController]
  final Duration duration;

  /// The callback that is called when the button is tapped or otherwise activated.
  ///
  /// If this is set to null, the button will be disabled.
  final Function onPressed;

  /// The color for the button's icon when it has the input focus.
  ///
  /// Defaults to [ThemeData.focusColor] of the ambient theme.
  final Color focusColor;

  /// The color for the button's icon when a pointer is hovering over it.
  ///
  /// Defaults to [ThemeData.hoverColor] of the ambient theme.
  final Color hoverColor;

  /// The secondary color of the button when the button is in the down (pressed)
  /// state. The highlight color is represented as a solid color that is overlaid over the
  /// button color (if any). If the highlight color has transparency, the button color
  /// will show through. The highlight fades in quickly as the button is held down.
  ///
  /// Defaults to the Theme's highlight color, [ThemeData.highlightColor].
  final Color highlightColor;

  /// The primary color of the button when the button is in the down (pressed) state.
  /// The splash is represented as a circular overlay that appears above the
  /// [highlightColor] overlay. The splash overlay has a center point that matches
  /// the hit point of the user touch event. The splash overlay will expand to
  /// fill the button area if the touch is held for long enough time. If the splash
  /// color has transparency then the highlight and button color will show through.
  ///
  /// Defaults to the Theme's splash color, [ThemeData.splashColor].
  final Color splashColor;

  /// The color to use for the icon inside the button, if the icon is disabled.
  /// Defaults to the [ThemeData.disabledColor] of the current [Theme].
  ///
  /// The icon is disabled if [onPressed] is null.
  final Color disabledColor;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode focusNode;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// Whether detected gestures should provide acoustic and/or haptic feedback.
  ///
  /// For example, on Android a tap will produce a clicking sound and a
  /// long-press will produce a short vibration, when feedback is enabled.
  ///
  /// See also:
  ///
  ///  * [Feedback] for providing platform-specific feedback to certain actions.
  final bool enableFeedback;

  /// Text that describes the action that will occur when the button is pressed.
  ///
  /// This text is displayed when the user long-presses on the button and is
  /// used for accessibility.
  final String tooltip;

  /// Optional size constraints for the button.
  ///
  /// When unspecified, defaults to:
  /// ```dart
  /// const BoxConstraints(
  ///   minWidth: kMinInteractiveDimension,
  ///   minHeight: kMinInteractiveDimension,
  /// )
  /// ```
  /// where [kMinInteractiveDimension] is 48.0, and then with visual density
  /// applied.
  ///
  /// The default constraints ensure that the button is accessible.
  /// Specifying this parameter enables creation of buttons smaller than
  /// the minimum size, but it is not recommended.
  ///
  /// The visual density uses the [visualDensity] parameter if specified,
  /// and `Theme.of(context).visualDensity` otherwise.
  final BoxConstraints constraints;

  /// Defines how compact the icon button's layout will be.
  ///
  /// {@macro flutter.material.themedata.visualDensity}
  ///
  /// See also:
  ///
  ///  * [ThemeData.visualDensity], which specifies the [density] for all widgets
  ///    within a [Theme].
  final VisualDensity visualDensity;

  /// The padding around the button's icon. The entire padded icon will react
  /// to input gestures.
  ///
  /// This property must not be null. It defaults to 8.0 padding on all sides.
  final EdgeInsets padding;

  /// Defines how the icon is positioned within the IconButton.
  ///
  /// This property must not be null. It defaults to [Alignment.center].
  ///
  /// See also:
  ///
  ///  * [Alignment], a class with convenient constants typically used to
  ///    specify an [AlignmentGeometry].
  ///  * [AlignmentDirectional], like [Alignment] for specifying alignments
  ///    relative to text direction.
  final Alignment alignment;

  /// The background [Color] of the [AnimatedIconButton] when button is not pressed.
  final Color startBackgroundColor;

  /// The background [Color] of the [AnimatedIconButton] when button is pressed.
  final Color endBackgroundColor;

  /// The custom [AnimationController] of the [AnimatedIconButton].
  ///
  /// When not specified the [AnimatedIconButton] will change it's icons and
  /// background color whenever [AnimatedIconButton] is pressed.
  final AnimationController animationController;

  /// The splash radius.
  ///
  /// If null, default splash radius of [Material.defaultSplashRadius] is used.
  /// Field of IconButton
  final double splashRadius;

  AnimatedIconButton({
    Key key,
    this.size,
    @required this.startIcon,
    @required this.endIcon,
    @required this.onPressed,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.splashColor,
    this.disabledColor,
    this.duration,
    this.focusNode,
    this.autofocus,
    this.tooltip,
    this.enableFeedback,
    this.constraints,
    this.visualDensity,
    this.padding,
    this.alignment,
    this.endBackgroundColor,
    this.startBackgroundColor,
    this.animationController,
    this.splashRadius,
  });

  @override
  createState() => _AnimatedIconButtonState(
      size: this.size,
      startIcon: this.startIcon,
      endIcon: this.endIcon,
      duration: this.duration,
      onPressed: this.onPressed,
      focusColor: this.focusColor,
      hoverColor: this.hoverColor,
      highlightColor: this.highlightColor,
      splashColor: this.splashColor,
      disabledColor: this.disabledColor,
      focusNode: this.focusNode,
      autofocus: this.autofocus,
      tooltip: this.tooltip,
      enableFeedback: this.enableFeedback,
      constraints: this.constraints,
      visualDensity: this.visualDensity,
      padding: this.padding,
      alignment: this.alignment,
      endBackgroundColor: this.endBackgroundColor,
      startBackgroundColor: this.startBackgroundColor,
      animationController: this.animationController,
      splashRadius: this.splashRadius);
}

class _AnimatedIconButtonState extends State<AnimatedIconButton>
    with SingleTickerProviderStateMixin {
  _AnimatedIconButtonState(
      {this.size,
      this.startIcon,
      this.endIcon,
      this.duration = defaultDuration,
      this.onPressed,
      this.focusColor,
      this.hoverColor,
      this.highlightColor,
      this.splashColor,
      this.disabledColor,
      this.focusNode,
      this.autofocus = false,
      this.tooltip,
      this.enableFeedback = true,
      this.constraints,
      this.visualDensity,
      this.padding,
      this.alignment = Alignment.center,
      this.endBackgroundColor,
      this.startBackgroundColor,
      this.animationController,
      this.splashRadius});

  double size;
  Icon startIcon;
  Icon endIcon;
  Color startBackgroundColor;
  Color endBackgroundColor;
  Duration duration;
  Function onPressed;
  Color focusColor;
  Color hoverColor;
  Color highlightColor;
  Color splashColor;
  Color disabledColor;
  FocusNode focusNode;
  bool autofocus;
  bool enableFeedback;
  String tooltip;
  BoxConstraints constraints;
  VisualDensity visualDensity;
  EdgeInsets padding;
  Alignment alignment;
  AnimationController animationController;
  double splashRadius;

  bool hasCustomAnimationController;
  Icon nowIcon;
  Color nowBackgroundColor;
  bool isIconAnimated = false;
  AnimationController _arrowAnimationController;
  Animation _arrowAnimation;
  AnimationStatus _lastStatus;
  static const Duration defaultDuration = Duration(milliseconds: 200);

  @override
  void initState() {
    hasCustomAnimationController = animationController != null;

    if (hasCustomAnimationController) {
      assert(duration == null,
          'Duration must be null when defining an animationController');
      duration = animationController.duration;
    }

    _arrowAnimationController = hasCustomAnimationController
        ? animationController
        : AnimationController(vsync: this, duration: duration);

    if (hasCustomAnimationController) _addStatusListener();

    _arrowAnimation =
        Tween(begin: 0.0, end: 1.0).animate(_arrowAnimationController);
    nowIcon = startIcon;
    nowBackgroundColor = startBackgroundColor;
    super.initState();
  }

  // Changes nowIcon and backgroundColor when _arrowAnimationController.forward()
  // and _arrowAnimationController.reverse() are called according to custom
  // animation controller.
  _addStatusListener() {
    _arrowAnimationController.addStatusListener((status) {
      if (status != _lastStatus &&
          (status == AnimationStatus.forward ||
              status == AnimationStatus.reverse)) {
        _lastStatus = status;
        _changeIcon();
        _changeBackgroundColor();
      }
    });
  }

  _changeIcon() async {
    var animationTime = duration.inMilliseconds;
    var halfDuration = Duration(milliseconds: animationTime ~/ 2);
    await Future.delayed(halfDuration);
    setState(() {
      nowIcon = nowIcon == startIcon ? endIcon : startIcon;
    });
  }

  _changeBackgroundColor() async {
    var animationTime = duration.inMilliseconds;
    var halfDuration = Duration(milliseconds: animationTime ~/ 2);
    await Future.delayed(halfDuration);
    setState(() {
      nowBackgroundColor = nowBackgroundColor == startBackgroundColor
          ? endBackgroundColor
          : startBackgroundColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return nowBackgroundColor == null
        ? buildIconButton()
        : CircleAvatar(
            radius: size ?? 30,
            backgroundColor: nowBackgroundColor ?? Colors.transparent,
            child: buildIconButton());
  }

  IconButton buildIconButton() {
    return IconButton(
        iconSize: size ?? 30,
        onPressed: hasCustomAnimationController
            ? onPressed
            : () {
                onPressed();
                _changeIcon();
                _changeBackgroundColor();
                _arrowAnimationController.isCompleted
                    ? _arrowAnimationController.reverse().then((_) => _)
                    : _arrowAnimationController.forward().then((_) => _);
              },
        icon: AnimatedBuilder(
            animation: _arrowAnimationController,
            builder: (BuildContext context, Widget child) {
              return Transform.rotate(
                  angle: _arrowAnimation.value * 2.0 * math.pi, child: child);
            },
            child: nowIcon),
        focusColor: focusColor,
        hoverColor: hoverColor,
        highlightColor: highlightColor,
        splashColor: splashColor,
        disabledColor: disabledColor,
        focusNode: focusNode,
        autofocus: autofocus ?? false,
        enableFeedback: enableFeedback ?? true,
        tooltip: tooltip,
        constraints: constraints,
        visualDensity: visualDensity,
        padding: padding ?? const EdgeInsets.all(8.0),
        alignment: alignment ?? Alignment.center,
        splashRadius: splashRadius);
  }
}
