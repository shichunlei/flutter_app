import 'package:flutter/material.dart';
import 'package:flutter_app/utils/utils.dart';

class BottomAppbar extends StatelessWidget {
  final Color backgroundColor;
  final List<Widget> actions;
  final Widget title;

  BottomAppbar(
      {Key key, this.backgroundColor = Colors.white, this.actions, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      Container(color: Colors.grey[100], height: 1),
      Material(
        color: backgroundColor,
        child: Container(
            height: Utils.navigationBarHeight - Utils.topSafeHeight,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  BackButton(),
                  Row(
                      mainAxisSize: MainAxisSize.min,
                      children: actions.isEmpty ? [] : actions)
                ])),
      )
    ]);
  }
}
