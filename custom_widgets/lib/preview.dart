import 'package:flutter/material.dart';

class PreView extends StatelessWidget {
  PreView({this.header, this.body, this.footer, Key key}) : super(key: key);

  final PreViewHeader header;
  final PreViewBody body;
  final PreViewFooter footer;

  getChildren() {
    List<Widget> list = [];
    if (header != null) list.add(header);
    if (body != null) list.add(body);
    if (footer != null) list.add(footer);
    return list.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Color(0xFFE5E5E5)),
              top: BorderSide(color: Color(0xFFE5E5E5))),
          color: Colors.white),
      child: Column(
        children: getChildren(),
      ),
    );
  }
}

/// PreViewItem组件
class PreViewItem extends StatelessWidget {
  PreViewItem({this.label, this.value, Key key}) : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(color: Color(0xFF999999), fontSize: 14.4),
          ),
          Text(
            value,
            style: TextStyle(color: Color(0xFF999999), fontSize: 14.4),
          )
        ],
      ),
    );
  }
}

/// PreViewBody组件
class PreViewBody extends StatelessWidget {
  PreViewBody({this.children = const [], Key key}) : super(key: key);

  final List<PreViewItem> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFE5E5E5)))),
      child: Column(
        children: children.toList(),
      ),
    );
  }
}

/// PreViewHeader组件
class PreViewHeader extends StatelessWidget {
  PreViewHeader({this.label, this.value, Key key}) : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10, right: 15),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: Color(0xFFE5E5E5),
                    width: 1 / MediaQuery.of(context).devicePixelRatio))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              label,
              style: TextStyle(color: Color(0xFF999999), fontSize: 14.4),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 19.2,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PreViewButton extends StatelessWidget {
  PreViewButton({this.text = "", this.onPressed, this.primary = false, Key key})
      : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final bool primary;

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      child: Container(
        height: 46,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: 18,
                color: primary == true ? Color(0xFF1AAD19) : Color(0xFF999999)),
          ),
        ),
      ),
      onPressed: onPressed,
    );
  }
}

class PreViewFooter extends StatelessWidget {
  PreViewFooter({this.children = const [], Key key}) : super(key: key);

  final List<PreViewButton> children;

  getChildren() {
    List<Widget> list = [];
    for (int i = 0; i < children.length; i++) {
      list.add(Expanded(child: children.elementAt(i)));
      list.add(Container(
        width: 1,
        height: 46,
        color: Color(0xFFE5E5E5),
      ));
    }
    return list.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: getChildren(),
    );
  }
}

/// 按下时不透明度发生变化
class TouchableOpacity extends StatefulWidget {
  TouchableOpacity({Key key, @required this.child, this.onPressed})
      : super(key: key);

  final Widget child;
  final VoidCallback onPressed;

  @override
  _TouchableOpacityState createState() => _TouchableOpacityState();
}

class _TouchableOpacityState extends State<TouchableOpacity> {
  double opacity = 1;

  _onTapDown(e) {
    setState(() {
      opacity = 0.2;
    });
  }

  _onTapUp(e) {
    setState(() {
      opacity = 1;
    });
    if (widget.onPressed != null) widget.onPressed();
  }

  _onTapCancel() {
    setState(() {
      opacity = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTapDown: this._onTapDown,
        onTapUp: this._onTapUp,
        onTapCancel: this._onTapCancel,
        child: Opacity(opacity: opacity, child: widget.child));
  }
}
