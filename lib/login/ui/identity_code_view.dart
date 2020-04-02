import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/res/colors.dart';

/// 墨水瓶（`InkWell`）可用时使用的字体样式。
final TextStyle _availableStyle =
    TextStyle(fontSize: 16.0, color: const Color(0xFF00CACE));

/// 墨水瓶（`InkWell`）不可用时使用的样式。
final TextStyle _unavailableStyle =
    TextStyle(fontSize: 16.0, color: greyCColor);

class IdentityCodeView extends StatefulWidget {
  /// 倒计时的秒数，默认60秒。
  final int seconds;

  /// 用户点击时的回调函数。
  final Function onTapCallback;

  /// 是否可以获取验证码，默认为`false`。
  final bool available;

  final EdgeInsetsGeometry padding;

  IdentityCodeView({
    Key key,
    this.seconds = 60,
    this.available = false,
    this.onTapCallback,
    this.padding,
  }) : super(key: key);

  @override
  createState() => _IdentityCodeViewState();
}

class _IdentityCodeViewState extends State<IdentityCodeView> {
  /// 倒计时的计时器。
  Timer _timer;

  /// 当前倒计时的秒数。
  int _seconds;

  /// 当前墨水瓶（`InkWell`）的字体样式。
  TextStyle inkWellStyle = _availableStyle;

  /// 当前墨水瓶（`InkWell`）的文本。
  String _verifyStr = '获取验证码';

  @override
  void initState() {
    super.initState();
    _seconds = widget.seconds;
  }

  @override
  void dispose() {
    _cancelTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 墨水瓶（`InkWell`）组件，响应触摸的矩形区域。
    return Padding(
        padding: widget.padding,
        child: widget.available
            ? InkWell(
                child: Text('  $_verifyStr  ', style: inkWellStyle),
                onTap: (_seconds == widget.seconds)
                    ? () {
                        _startTimer();
                        inkWellStyle = _unavailableStyle;
                        _verifyStr = '已发送$_seconds' + 's';
                        setState(() {});
                        widget.onTapCallback();
                      }
                    : null)
            : InkWell(child: Text('  获取验证码  ', style: _unavailableStyle)));
  }

  /// 启动倒计时的计时器。
  void _startTimer() {
    /// 计时器（`Timer`）组件的定期（`periodic`）构造函数，创建一个新的重复计时器。
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        _cancelTimer();
        _seconds = widget.seconds;
        inkWellStyle = _availableStyle;
        setState(() {});
        return;
      }
      _seconds--;
      _verifyStr = '已发送$_seconds' + 's';
      setState(() {});
      if (_seconds == 0) {
        _verifyStr = '重新发送';
      }
    });
  }

  /// 取消倒计时的计时器。
  void _cancelTimer() {
    // 计时器（`Timer`）组件的取消（`cancel`）方法，取消计时器。
    _timer?.cancel();
  }
}
