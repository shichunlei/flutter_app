import 'package:flutter/material.dart';
import 'package:flutter_app/res/colors.dart';

class SelectedText extends StatelessWidget {
  final String text;
  final double fontSize;
  final bool selected;
  final Color unSelectedTextColor;
  final GestureTapCallback onTap;
  final bool enable;

  const SelectedText(this.text,
      {Key key,
      this.fontSize: 14.0,
      this.selected: false,
      this.unSelectedTextColor: grey3Color,
      this.enable: true,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: BorderRadius.circular(16.0),
        onTap: enable ? onTap : null,
        child: Container(
            constraints: BoxConstraints(
                minWidth: 32.0, maxHeight: 32.0, minHeight: 32.0),
            padding:
                EdgeInsets.symmetric(horizontal: fontSize > 14 ? 10.0 : 0.0),
            decoration: selected
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0x805793FA),
                          offset: Offset(0.0, 2.0),
                          blurRadius: 8.0,
                          spreadRadius: 0.0)
                    ],
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFF5758FA), Color(0xFF5793FA)]))
                : null,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(text,
                      style: TextStyle(color: textColor(), fontSize: fontSize))
                ])));
  }

  textColor() => enable
      ? (selected ? Colors.white : unSelectedTextColor)
      : greyCColor;
}
