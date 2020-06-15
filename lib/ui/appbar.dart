import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../page_index.dart';

class ToolBar extends StatelessWidget {
  final Widget leading;

  final bool automaticallyImplyLeading;

  final Widget title;

  final List<Widget> actions;

  final PreferredSizeWidget bottom;

  final double elevation;

  final Color backgroundColor;

  final Brightness brightness;

  final IconThemeData iconTheme;

  final TextTheme textTheme;

  final bool centerTitle;

  ToolBar({
    Key key,
    this.leading,
    this.automaticallyImplyLeading: true,
    this.title,
    this.actions,
    this.bottom,
    this.elevation: 0.0,
    this.backgroundColor: Colors.transparent,
    this.brightness,
    this.iconTheme,
    this.textTheme,
    this.centerTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Utils.navigationBarHeight,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: elevation,
          backgroundColor: backgroundColor,
          actions: actions,
          leading: leading,
          title: title,
          centerTitle: centerTitle,
          textTheme: textTheme,
          iconTheme: iconTheme,
          brightness: brightness,
          bottom: bottom,
          automaticallyImplyLeading: automaticallyImplyLeading,
        ),
      ),
    );
  }
}

class SearchBar extends StatefulWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final String hintText;
  final Function(String) onPressed;
  final bool showBackIcon;

  SearchBar(
      {Key key,
      this.backgroundColor: Colors.white,
      this.hintText,
      this.onPressed,
      this.showBackIcon: false})
      : super(key: key);

  @override
  createState() => _SearchBarState();

  @override
  Size get preferredSize =>
      Size.fromHeight(Utils.navigationBarHeight - Utils.topSafeHeight);
}

class _SearchBarState extends State<SearchBar> {
  SystemUiOverlayStyle overlayStyle = SystemUiOverlayStyle.dark;
  TextEditingController _controller = TextEditingController();

  bool showClear = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      overlayStyle =
          ThemeData.estimateBrightnessForColor(widget.backgroundColor) ==
                  Brightness.light
              ? SystemUiOverlayStyle.light
              : SystemUiOverlayStyle.dark;
    });

    _controller.addListener(() {
      setState(() {
        showClear = _controller.text != '' &&
            _controller.text.isNotEmpty &&
            _controller.text.length > 0;
      });
    });
  }

  Color getColor() {
    return overlayStyle == SystemUiOverlayStyle.dark
        ? Colors.white
        : Color(0xFF333333);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: overlayStyle,
        child: Material(
            child: AppBar(
                elevation: 0,
                backgroundColor: widget.backgroundColor,
                automaticallyImplyLeading: widget.showBackIcon,
                titleSpacing: 0,
                title: Container(
                    margin: EdgeInsets.only(left: widget.showBackIcon ? 0 : 12),
                    height: 32.0,
                    decoration: BoxDecoration(
                        color: Color(0xFFF6F6F6),
                        borderRadius: BorderRadius.circular(4.0)),
                    child: TextField(
                        // autofocus: true,
                        controller: _controller,
                        maxLines: 1,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                                top: 6.0, left: -12.0, right: -12.0),
                            border: InputBorder.none,
                            icon: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Icon(Icons.search, color: greyCColor)),
                            hintText: "${widget.hintText}",
                            hintStyle: TextStyles.textGreyC14,
                            suffixIcon: !showClear
                                ? SizedBox()
                                : InkWell(
                                    child: Icon(Icons.close, color: greyCColor),
                                    onTap: () => _controller.text = "")))),
                actions: <Widget>[
              Container(
                  margin: const EdgeInsets.all(12.0),
                  width: 44.0,
                  child: FlatButton(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      color: Color(0xff4688FA),
                      textColor: Colors.white,
                      onPressed: () => widget.onPressed(_controller.text),
                      child: Text("搜索", style: TextStyle(fontSize: 14)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0))))
            ])));
  }
}
