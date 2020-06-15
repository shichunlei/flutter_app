import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/page_index.dart';

enum CodeInputType {
  squareBox, //方框类型
  underLine, //下划线类型
  circle, //圆形
  round
}

enum KeyboardType { none, number, letter }

class CodeInputText extends StatefulWidget {
  final int length;
  final CodeInputType type;
  final bool obscureText;

  final Function(String value) callBack;

  final KeyboardType keyboardType;

  final double radius;

  const CodeInputText(
      {Key key,
      this.length: 6,
      this.type: CodeInputType.squareBox,
      this.callBack,
      this.keyboardType: KeyboardType.none,
      this.obscureText: false,
      this.radius})
      : assert(length >= 4 && length <= 6),
        super(key: key);

  @override
  createState() => _CodeInputTextState();
}

class _CodeInputTextState extends State<CodeInputText> {
  TextEditingController _controller = TextEditingController();

  Pattern pattern = RegExp("[a-z,0-9,A-Z]");

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      setState(() {});
    });

    if (widget.keyboardType == KeyboardType.letter) {
      pattern = RegExp("[a-z,A-Z]");
    } else if (widget.keyboardType == KeyboardType.number) {
      pattern = RegExp("[0-9]");
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _newCells = [];

    if (widget.type == CodeInputType.round) {
      for (int i = 1; i <= widget.length; i++) {
        _newCells.add(SquareInputCell(
            isFocused: _controller.text.length == i - 1,
            text: _controller.text.length >= i
                ? _controller.text.substring(i - 1, i)
                : '',
            obscureText: widget.obscureText,
            radius: widget.radius ?? 10.0));
      }
    } else if (widget.type == CodeInputType.squareBox) {
      for (int i = 1; i <= widget.length; i++) {
        _newCells.add(SquareInputCell(
            isFocused: _controller.text.length == i - 1,
            text: _controller.text.length >= i
                ? _controller.text.substring(i - 1, i)
                : '',
            obscureText: widget.obscureText,
            radius: 0.0));
      }
    } else if (widget.type == CodeInputType.circle) {
      for (int i = 1; i <= widget.length; i++) {
        _newCells.add(CircleInputCell(
            isFocused: _controller.text.length == i - 1,
            text: _controller.text.length >= i
                ? _controller.text.substring(i - 1, i)
                : '',
            obscureText: widget.obscureText));
      }
    } else {
      for (int i = 1; i <= widget.length; i++) {
        _newCells.add(UnderlineInputCell(
            isFocused: _controller.text.length == i - 1,
            text: _controller.text.length >= i
                ? _controller.text.substring(i - 1, i)
                : '',
            obscureText: widget.obscureText));
      }
    }

    return Container(
        height: 45,
        width: double.infinity,
        child: Stack(children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _newCells),
          Opacity(
              opacity: 0,
              child: TextField(
                controller: _controller,
                inputFormatters: [WhitelistingTextInputFormatter(pattern)],
                maxLength: widget.length,
                autofocus: true,
                keyboardType: widget.keyboardType == KeyboardType.number
                    ? TextInputType.number
                    : TextInputType.text,
                onChanged: (value) {
                  widget.callBack(value);
                  if (value.length == widget.length) {
                    /// 失去焦点，隐藏键盘
                    Utils.hideKeyboard(context);
                  }
                },
                obscureText: widget.obscureText,
              ))
        ]));
  }
}

class SquareInputCell extends StatefulWidget {
  final bool isFocused;
  final String text;
  final bool obscureText;
  final double radius;

  const SquareInputCell(
      {Key key,
      this.isFocused,
      this.text,
      this.obscureText: false,
      this.radius})
      : super(key: key);

  @override
  createState() => _SquareInputCellState();
}

class _SquareInputCellState extends State<SquareInputCell> {
  /// 聚焦时的光标颜色，实现光标闪烁
  Color cursorColor;
  Timer timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      cursorColor = Colors.transparent;
      if (mounted) {
        setState(() {});
      }
      Future.delayed(Duration(milliseconds: 500), () {
        cursorColor = Theme.of(context).primaryColor;
        if (mounted) {
          setState(() {});
        }
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: widget.isFocused
                  ? Theme.of(context).primaryColor
                  : Colors.grey[300],
              width: 1.5),
          borderRadius: BorderRadius.circular(widget.radius)),
      child: widget.isFocused
          ? Container(
              margin: EdgeInsets.symmetric(horizontal: 20.2, vertical: 11),
              color: cursorColor)
          : widget.obscureText
              ? widget.text == ''
                  ? SizedBox()
                  : Icon(Icons.brightness_1, size: 20)
              : Text(widget.text ?? '', style: TextStyle(fontSize: 22)),
      alignment: Alignment.center,
    );
  }
}

class UnderlineInputCell extends StatelessWidget {
  final bool isFocused;
  final String text;
  final bool obscureText;

  const UnderlineInputCell(
      {Key key, this.isFocused, this.text, this.obscureText: false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      width: 35,
      height: 45,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: isFocused
                      ? Theme.of(context).primaryColor
                      : Colors.black54,
                  width: 2))),
      child: obscureText
          ? text == '' ? SizedBox() : Icon(Icons.brightness_1, size: 20)
          : Text(text ?? '', style: TextStyle(fontSize: 22)),
      alignment: Alignment.center,
    );
  }
}

class CircleInputCell extends StatelessWidget {
  final bool isFocused;
  final String text;
  final bool obscureText;

  CircleInputCell({Key key, this.isFocused, this.text, this.obscureText: false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
              color:
                  isFocused ? Theme.of(context).primaryColor : Colors.grey[300],
              width: 1.5)),
      child: obscureText
          ? text == '' ? SizedBox() : Icon(Icons.brightness_1, size: 20)
          : Text(text ?? '', style: TextStyle(fontSize: 22)),
      alignment: Alignment.center,
    );
  }
}
