import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Toast {
  static final int LENGTH_SHORT = 1;
  static final int LENGTH_LONG = 2;
  static final int BOTTOM = 0;
  static final int CENTER = 1;
  static final int TOP = 2;
  static ToastView _toastView;

  static void show(String msg, BuildContext context,
      {int duration = 1,
      int gravity = 0,
      Color backgroundColor = const Color(0xAA000000),
      Color textColor = Colors.white,
      double backgroundRadius = 20}) {
    _toastView?.dismiss();
    _toastView = null;
    _toastView = ToastView(msg, context, duration, gravity, backgroundColor,
        textColor, backgroundRadius);
  }
}

class ToastView {
  bool _isVisible = false;
  OverlayState overlayState;
  OverlayEntry overlayEntry;

  ToastView(String msg, BuildContext context, int duration, int gravity,
      Color background, Color textColor, double backgroundRadius) {
    createView(msg, context, duration, gravity, background, textColor,
        backgroundRadius);
  }

  void createView(String msg, BuildContext context, int duration, int gravity,
      Color background, Color textColor, double backgroundRadius) async {
    overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(
      builder: (BuildContext context) => ToastWidget(
          widget: Container(
            width: MediaQuery.of(context).size.width,
            child: FittedBox(
                alignment: Alignment.center,
                fit: BoxFit.none,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: 32),
                  child: Container(
                    decoration: BoxDecoration(
                      color: background,
                      borderRadius: BorderRadius.circular(backgroundRadius),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Center(
                      child: Text(msg,
                          softWrap: true,
                          style: TextStyle(fontSize: 15, color: textColor)),
                    ),
                  ),
                )),
          ),
          gravity: gravity),
    );
    overlayState.insert(overlayEntry);
    _isVisible = true;
    await Future.delayed(
        Duration(seconds: duration == null ? Toast.LENGTH_SHORT : duration));
    this.dismiss();
  }

  dismiss() async {
    if (!_isVisible) {
      return;
    }
    this._isVisible = false;
    overlayEntry?.remove();
  }
}

class ToastWidget extends StatelessWidget {
  ToastWidget({
    Key key,
    @required this.widget,
    @required this.gravity,
  }) : super(key: key);

  final Widget widget;
  final int gravity;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: gravity == 2 ? 50 : null,
        bottom: gravity == 0 ? 50 : null,
        child: Material(
          color: Colors.transparent,
          child: widget,
        ));
  }
}
