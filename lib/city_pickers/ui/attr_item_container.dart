import 'package:flutter/material.dart';

class AttrItemContainer extends StatefulWidget {
  final String title;
  final Widget child;

  AttrItemContainer({Key key, this.title, this.child}) : super(key: key);

  @override
  _AttrItemContainerState createState() => _AttrItemContainerState();
}

class _AttrItemContainerState extends State<AttrItemContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
      child: Container(
          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: Theme.of(context).dividerColor,
              ),
            ),
          ),
          child: Row(
            children: <Widget>[
              Text("${widget.title}"),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: widget.child,
                ),
              ),
            ],
          )),
    );
  }
}
