import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:rxdart/rxdart.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

import '../page_index.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final int maxLength;
  final bool autoFocus;
  final TextInputType keyboardType;
  final String hintText;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final bool isInputPwd;
  final Function getVCode;
  final KeyboardActionsConfig config;

  CustomTextField(
      {Key key,
      @required this.controller,
      this.maxLength: 16,
      this.autoFocus: false,
      this.keyboardType: TextInputType.text,
      this.hintText: "",
      this.focusNode,
      this.nextFocusNode,
      this.isInputPwd: false,
      this.getVCode,
      this.config})
      : super(key: key);

  @override
  createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isShowPwd = false;
  bool _isShowDelete = true;
  bool _isClick = true;

  /// 倒计时秒数
  final int second = 30;

  /// 当前秒数
  int s;
  StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    //监听输入改变
    widget.controller.addListener(() {
      setState(() {
        _isShowDelete = widget.controller.text.isEmpty;
      });
    });
    if (widget.config != null && defaultTargetPlatform == TargetPlatform.iOS) {
      // 因Android平台输入法兼容问题，所以只配置IOS平台
      FormKeyboardActions.setKeyboardActions(context, widget.config);
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.centerRight, children: <Widget>[
      TextField(
          focusNode: widget.focusNode,
          maxLength: widget.maxLength,

          /// 键盘动作按钮点击之后执行的代码： 光标切换到指定的输入框
          onEditingComplete: widget.nextFocusNode == null
              ? null
              : () => FocusScope.of(context).requestFocus(widget.nextFocusNode),
          obscureText: widget.isInputPwd ? !_isShowPwd : false,
          autofocus: widget.autoFocus,
          controller: widget.controller,
          textInputAction: TextInputAction.done,
          keyboardType: widget.keyboardType,
          // 数字、手机号限制格式为0到9(白名单)， 密码限制不包含汉字（黑名单）
          inputFormatters: (widget.keyboardType == TextInputType.number ||
                  widget.keyboardType == TextInputType.phone)
              ? [WhitelistingTextInputFormatter(RegExp("[0-9]"))]
              : [BlacklistingTextInputFormatter(RegExp("[\u4e00-\u9fa5]"))],
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
              hintText: widget.hintText,
              hintStyle: TextStyles.textGrayC14,
              counterText: "",
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 0.8)),
              enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color(0xFFEEEEEE), width: 0.8)))),
      Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Offstage(
            offstage: _isShowDelete,
            child: InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                child: Icon(Icons.close, size: 18.0),
                onTap: () => setState(() => widget.controller.text = ""))),
        Offstage(
            offstage: !widget.isInputPwd,
            child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Icon(
                        _isShowPwd
                            ? CustomIcon.show_password
                            : CustomIcon.hidden_password,
                        size: 18.0),
                    onTap: () {
                      setState(() => _isShowPwd = !_isShowPwd);
                    }))),
        Offstage(
            offstage: widget.getVCode == null,
            child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Container(
                    height: 26.0,
                    width: 76.0,
                    child: FlatButton(
                        onPressed: _isClick
                            ? () {
                                widget.getVCode();
                                setState(() {
                                  s = second;
                                  _isClick = false;
                                });
                                _subscription = Observable.periodic(
                                        Duration(seconds: 1), (i) => i)
                                    .take(second)
                                    .listen((i) => setState(() {
                                          s = second - i - 1;
                                          _isClick = s < 1;
                                        }));
                              }
                            : null,
                        padding: const EdgeInsetsDirectional.only(
                            start: 8.0, end: 8.0),
                        textColor: Colors.blueAccent,
                        color: Colors.transparent,
                        disabledTextColor: Colors.white,
                        disabledColor: Color(0xFFcccccc),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1.0),
                            side: BorderSide(
                                color: _isClick
                                    ? Colors.blueAccent
                                    : Color(0xFFcccccc),
                                width: 0.8)),
                        child: Text(
                            _isClick
                                ? "${S.of(context).get_v_code}"
                                : "（$s s）",
                            style: TextStyle(fontSize: Dimens.font_sp12))))))
      ])
    ]);
  }
}
