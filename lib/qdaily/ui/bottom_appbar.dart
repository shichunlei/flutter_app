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
    return Material(
      elevation: 16,
      color: backgroundColor,
      child: Container(
        height: Utils.navigationBarHeight -
            Utils.topSafeHeight +
            Utils.bottomSafeHeight,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              BackButton(),
              Row(
                  mainAxisSize: MainAxisSize.min,
                  children: actions.isEmpty ? [] : actions)
            ]),
        padding: EdgeInsets.only(bottom: Utils.bottomSafeHeight),
      ),
    );
  }
}
