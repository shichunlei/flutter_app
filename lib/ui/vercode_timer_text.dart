import 'dart:async';

import 'package:flutter/material.dart';

class VerCodeTimerText extends StatefulWidget {
  final int seconds;

  const VerCodeTimerText({Key key, this.seconds: 60}) : super(key: key);

  @override
  createState() => _VerCodeTimerTextState();
}

class _VerCodeTimerTextState extends State<VerCodeTimerText> {
  Timer _timer;

  /// 倒计时数值
  var _countdownTime = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer.cancel();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        child: Text(handleCodeAutoSizeText(),
            style: TextStyle(color: ThemeData().primaryColor, fontSize: 34)),
        onPressed: _countdownTime > 0 ? null : () => startCountdown(),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        padding: EdgeInsets.only(right: 0));
  }

  String handleCodeAutoSizeText() {
    if (_countdownTime > 0)
      return '{$_countdownTime}s后重新发送';
    else
      return '获取验证码';
  }

  /// 倒计时方法
  startCountdown() {
    /// 倒计时时间
    _countdownTime = widget.seconds;
    final call = (timer) {
      if (_countdownTime < 1) {
        _timer.cancel();
      } else {
        setState(() => _countdownTime -= 1);
      }
    };
    if (_timer == null) {
      _timer = Timer.periodic(Duration(seconds: 1), call);
    }
  }
}
