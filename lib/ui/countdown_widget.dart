import 'dart:async';

import 'package:flutter/material.dart';

/// 倒计时控件
class CountdownWidget extends StatefulWidget {
  final onCountdownFinishCallBack;
  final int seconds;

  CountdownWidget(
      {Key key, @required this.onCountdownFinishCallBack, this.seconds: 5})
      : super(key: key);

  @override
  createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownWidget> {
  var _seconds;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _seconds = widget.seconds;
    _startTimer();
  }

  @override
  void dispose() {
    _cancelTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Color(0x2AFFFFFF),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Text(
          '$_seconds',
          style: TextStyle(fontSize: 17.0, color: Colors.white),
        ),
        margin: EdgeInsets.only(right: 10),
        padding: EdgeInsets.all(10));
  }

  /// 启动倒计时的计时器。
  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
      if (_seconds <= 1) {
        widget.onCountdownFinishCallBack(true);
        _cancelTimer();
        return;
      }
      _seconds--;
    });
  }

  /// 取消倒计时的计时器。
  void _cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }
}
