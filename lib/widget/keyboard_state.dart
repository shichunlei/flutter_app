import 'dart:io';

import 'package:flutter/material.dart';

class KeyboardStatePage extends StatefulWidget {
  const KeyboardStatePage({Key key}) : super(key: key);

  @override
  createState() => _KeyboardStatePageState();
}

class _KeyboardStatePageState extends State<KeyboardStatePage>
    with WidgetsBindingObserver {
  // 输入框的焦点实例
  FocusNode _focusNode;

  // 当前键盘是否是激活状态
  bool isKeyboardActived = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    // 监听输入框焦点变化
    _focusNode.addListener(_onFocus);
    // 创建一个界面变化的观察者
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 当前是安卓系统并且在焦点聚焦的情况下
      if (Platform.isAndroid && _focusNode.hasFocus) {
        if (isKeyboardActived) {
          isKeyboardActived = false;
          // 使输入框失去焦点
          _focusNode.unfocus();
          return;
        }
        isKeyboardActived = true;
      }
    });
  }

  // 既然有监听当然也要有卸载，防止内存泄漏嘛
  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  // 焦点变化时触发的函数
  _onFocus() {
    if (_focusNode.hasFocus) {
      // 聚焦时候的操作
      return;
    }

    // 失去焦点时候的操作
    isKeyboardActived = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: Text('键盘监听')),
      body: Column(
        children: [
          TextField(
            focusNode: _focusNode,
            textInputAction: TextInputAction.done,
          )
        ],
      ),
    );
  }
}
