import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/generated/i18n.dart';

import '../page_index.dart';

class TextFieldView extends StatelessWidget {
  final EdgeInsets margin;
  final IconData icon;
  final String hintText;
  final TextStyle style;
  final TextStyle hintStyle;
  final TextEditingController controller;
  final Color bgColor;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final BoxBorder border;

  TextFieldView({
    Key key,
    this.margin: const EdgeInsets.symmetric(horizontal: 28),
    this.icon,
    this.hintText,
    this.style,
    this.hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
    this.controller,
    this.bgColor,
    this.focusNode,
    this.keyboardType,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: margin,
      decoration: BoxDecoration(
        color: bgColor ?? Theme.of(context).scaffoldBackgroundColor,
        border: border ?? Border.all(color: Color(0xff0000ff), width: 0.5),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 22),
          Gaps.hGap12,
          Expanded(
            child: TextField(
              controller: controller,
              style: style, //.copyWith(textBaseline: TextBaseline.alphabetic),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: hintStyle,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
  final Duration duration;
  final Widget prefixIcon;
  final TextStyle hintTextStyle;

  CustomTextField({
    Key key,
    @required this.controller,
    this.maxLength: 16,
    this.autoFocus: false,
    this.keyboardType: TextInputType.text,
    this.hintText: "",
    this.focusNode,
    this.nextFocusNode,
    this.isInputPwd: false,
    this.getVCode,
    this.prefixIcon,
    this.hintTextStyle,
    this.duration: const Duration(seconds: 60),
  }) : super(key: key);

  @override
  createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isShowPwd = false;
  bool _isShowDelete = true;

  final StreamController<Model> _streamController = StreamController<Model>();

  /// 倒计时秒数
  int second;

  /// 当前秒数
  int s;

  @override
  void initState() {
    super.initState();
    second = widget.duration.inSeconds;

    //监听输入改变
    widget.controller.addListener(() {
      setState(() {
        _isShowDelete = widget.controller.text.isEmpty;
      });
    });
  }

  Timer _timer;

  @override
  void dispose() {
    _streamController?.close();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.centerRight, children: <Widget>[
      TextField(
          focusNode: widget.focusNode,
          maxLength: widget.maxLength,
          style: TextStyle(textBaseline: TextBaseline.alphabetic),

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
              hintStyle: widget.hintTextStyle ?? TextStyles.textGreyC14,
              counterText: "",
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 0.8)),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 0.8)),
              prefixIcon: widget.prefixIcon)),
      Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Visibility(
            visible: !_isShowDelete,
            child: InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                child: Icon(Icons.close, size: 18.0),
                onTap: () => setState(() => widget.controller.text = ""))),
        Visibility(
            visible: widget.isInputPwd,
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
        Visibility(
            visible: widget.getVCode != null,
            child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Container(
                    height: 26.0,
                    width: 76.0,
                    child: StreamBuilder<Model>(
                        stream: _streamController.stream,
                        initialData: Model(second: second, isClick: true),
                        builder: (BuildContext context,
                            AsyncSnapshot<Model> snapshot) {
                          return FlatButton(
                              onPressed: snapshot.data.isClick
                                  ? () {
                                      _streamController.sink.add(Model(
                                          second: second, isClick: false));
                                      widget.getVCode();
                                      s = second;

                                      _timer = Timer.periodic(
                                          Duration(seconds: 1), (timer) {
                                        if (s <= 0) {
                                          _streamController.sink.add(Model(
                                              second: --s, isClick: true));
                                          _timer?.cancel();
                                        } else {
                                          _streamController.sink.add(Model(
                                              second: --s, isClick: false));
                                        }
                                      });
                                    }
                                  : null,
                              padding: const EdgeInsetsDirectional.only(
                                  start: 8.0, end: 8.0),
                              textColor: Colors.blueAccent,
                              color: Colors.transparent,
                              disabledTextColor: Colors.white,
                              disabledColor: greyCColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(1.0),
                                  side: BorderSide(
                                      color: snapshot.data.isClick
                                          ? Colors.blueAccent
                                          : greyCColor,
                                      width: 0.8)),
                              child: Text(
                                  snapshot.data.isClick
                                      ? "${S.of(context).get_v_code}"
                                      : "（${snapshot.data.second} s）",
                                  style:
                                      TextStyle(fontSize: Dimens.font_sp12)));
                        }))))
      ])
    ]);
  }
}

class Model {
  bool isClick;
  int second;

  Model({this.isClick, this.second});
}

class TextFieldItem extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String hintText;
  final TextInputType keyboardType;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final int maxLines;
  final int maxLength;
  final TextAlign textAlign;
  final Color bgColor;

  const TextFieldItem({
    Key key,
    this.controller,
    @required this.title,
    this.keyboardType: TextInputType.text,
    this.hintText: "",
    this.focusNode,
    this.nextFocusNode,
    this.maxLines: 1,
    this.maxLength,
    this.textAlign: TextAlign.start,
    this.bgColor: Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: bgColor,
        height: maxLines == 1 ? 55.0 : maxLines * 55.0 * 0.75,
        margin: const EdgeInsets.only(left: 16.0, right: 16),
        width: double.infinity,
        child: Row(
            crossAxisAlignment: maxLines == 1
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Text(title, style: TextStyles.textDark14)),
              Expanded(
                  child: TextField(
                      textAlign: textAlign,
                      maxLength: maxLength,
                      style: TextStyles.textDark14,
                      maxLines: maxLines,
                      focusNode: focusNode,
                      keyboardType: keyboardType,
                      inputFormatters: (keyboardType == TextInputType.number ||
                              keyboardType == TextInputType.phone)
                          ? [WhitelistingTextInputFormatter(RegExp("[0-9]"))]
                          : keyboardType ==
                                  TextInputType.numberWithOptions(decimal: true)
                              ? [UsNumberTextInputFormatter()]
                              : [BlacklistingTextInputFormatter(RegExp(""))],
                      controller: controller,
                      onEditingComplete: nextFocusNode == null
                          ? null
                          : () => FocusScope.of(context)
                              .requestFocus(nextFocusNode),
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 16.0),
                          hintText: hintText,
                          counterText: "",
                          border: InputBorder.none,
                          hintStyle: TextStyles.textGreyC14)))
            ]));
  }
}

/// 只允许输入小数
class UsNumberTextInputFormatter extends TextInputFormatter {
  static const defaultDouble = 0.001;

  static double strToFloat(String str, [double defaultValue = defaultDouble]) {
    try {
      return double.parse(str);
    } catch (e) {
      return defaultValue;
    }
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String value = newValue.text;
    int selectionIndex = newValue.selection.end;
    if (value == ".") {
      value = "0.";
      selectionIndex++;
    } else if (value != "" &&
        value != defaultDouble.toString() &&
        strToFloat(value, defaultDouble) == defaultDouble) {
      value = oldValue.text;
      selectionIndex = oldValue.selection.end;
    }
    return TextEditingValue(
        text: value,
        selection: TextSelection.collapsed(offset: selectionIndex));
  }
}

class CTextField extends StatelessWidget {
  CTextField({
    this.controller,
    this.hintText,
    this.obscure: false,
    this.icon,
    this.focusNode,
  });

  final TextEditingController controller;
  final String hintText;
  final bool obscure;
  final IconData icon;
  final focusNode;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
        child: Row(children: <Widget>[
          Icon(icon, color: Colors.yellow[900]),
          SizedBox(width: width / 30),
          Expanded(
              child: TextField(
                  focusNode: focusNode,
                  controller: controller,
                  obscureText: obscure,
                  decoration: InputDecoration.collapsed(
                      hintText: hintText,
                      hintStyle:
                          TextStyle(fontSize: 16, color: Colors.white54))))
        ]),
        padding: EdgeInsets.only(bottom: 4.0),
        margin: EdgeInsets.only(top: 40, right: 20, left: 20),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.yellow[900]))));
  }
}

class CustomTF extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String hintText;
  final bool obscure;
  final IconData icon;
  final focusNode;

  final TextInputType keyboardType;

  CustomTF({
    Key key,
    @required this.title,
    this.controller,
    this.hintText,
    this.obscure: false,
    this.icon,
    this.focusNode,
    this.keyboardType: TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('$title', style: TextStyles.kLabelStyle),
          SizedBox(height: 10.0),
          Container(
              alignment: Alignment.centerLeft,
              decoration: kBoxDecorationStyle,
              height: 60.0,
              child: TextField(
                  keyboardType: keyboardType,
                  controller: controller,
                  focusNode: focusNode,
                  obscureText: obscure,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 14.0),
                      prefixIcon: Icon(icon, color: Colors.white),
                      hintText: '$hintText',
                      hintStyle: TextStyles.kHintTextStyle)))
        ]);
  }
}

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final IconData prefixIconData;
  final IconData suffixIconData;
  final bool obscureText;
  final Function onChanged;
  final FocusNode focusNode;
  final TextEditingController controller;

  TextFieldWidget(
      {this.hintText,
      this.prefixIconData,
      this.suffixIconData,
      this.obscureText,
      this.onChanged,
      this.controller,
      this.focusNode});

  @override
  Widget build(BuildContext context) {
    return TextField(
        onChanged: onChanged,
        obscureText: obscureText,
        controller: controller,
        cursorColor: const Color(0xFF373564),
        focusNode: focusNode,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16.0),
        decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.white),
            focusColor: Colors.white,
            filled: true,
            enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.white)),
            labelText: hintText,
            hintStyle: TextStyle(color: const Color(0xFF373564), fontSize: 14),
            prefixIcon: Icon(prefixIconData, size: 20, color: Colors.white),
            suffixIcon: GestureDetector(
                child: Icon(suffixIconData, size: 20, color: Colors.white))));
  }
}
