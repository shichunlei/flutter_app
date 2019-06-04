import 'package:flutter/material.dart';
import 'dropdown_menu_controller.dart';

typedef OnItemTap<T> = void Function(T value);

class DropDownHeader extends StatefulWidget {
  final Color color;
  final double borderWidth;
  final Color borderColor;
  TextStyle style;
  TextStyle dropDownStyle;
  final double iconSize;
  final Color iconColor;
  Color iconDropDownColor;

//  final List<String> menuStrings;
  final double height;
  final double dividerHeight;
  final Color dividerColor;
  final DropdownMenuController controller;
  final OnItemTap onItemTap;
  final List<DropDownHeaderItem> items;
  final GlobalKey stackKey;

  DropDownHeader({
    Key key,
    @required this.items,
    @required this.controller,
    @required this.stackKey,
    this.style = const TextStyle(color: Color(0xFF666666), fontSize: 13),
    this.dropDownStyle,
    this.height = 40,
    this.iconColor = const Color(0xFFafada7),
    this.iconDropDownColor,
    this.iconSize = 20,
    this.borderWidth = 1,
    this.borderColor = const Color(0xFFeeede6),
    this.dividerHeight = 20,
    this.dividerColor = const Color(0xFFeeede6),
    this.onItemTap,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  createState() => _DropDownHeaderState();
}

class _DropDownHeaderState extends State<DropDownHeader>
    with SingleTickerProviderStateMixin {
  bool _isShowDropDownItemWidget = false;
  double _screenWidth;
  double _screenHeight;
  int _menuCount;
  GlobalKey _keyDropDownHearder = GlobalKey();

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(_onController);
  }

  _onController() {
    print(widget.controller.menuIndex);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('_DropDownHeaderState.build');

    widget.dropDownStyle ??=
        TextStyle(color: Theme.of(context).primaryColor, fontSize: 13);
    widget.iconDropDownColor ??= Theme.of(context).primaryColor;

    MediaQueryData mediaQuery = MediaQuery.of(context);
    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;
    _menuCount = widget.items.length;

    var gridView = GridView.count(
      crossAxisCount: _menuCount,
      childAspectRatio: (_screenWidth / _menuCount) / widget.height,
      children: widget.items.map<Widget>((item) {
        return _menu(item);
      }).toList(),
    );

    return Container(
      key: _keyDropDownHearder,
      height: widget.height,
//      padding: EdgeInsets.only(top: 1, bottom: 1),
      decoration: BoxDecoration(
        border:
            Border.all(color: widget.borderColor, width: widget.borderWidth),
      ),
      child: gridView,
    );
  }

  dispose() {
    super.dispose();
  }

  _menu(DropDownHeaderItem item) {
    int index = widget.items.indexOf(item);
    int menuIndex = widget.controller.menuIndex;
    _isShowDropDownItemWidget = index == menuIndex && widget.controller.isShow;

    return GestureDetector(
      onTap: () {
        final RenderBox overlay =
            widget.stackKey.currentContext.findRenderObject();

        final RenderBox dropDownItemRenderBox =
            _keyDropDownHearder.currentContext.findRenderObject();

        var position =
            dropDownItemRenderBox.localToGlobal(Offset.zero, ancestor: overlay);
        debugPrint("POSITION : $position ");
        var size = dropDownItemRenderBox.size;
        debugPrint("SIZE : $size");

        widget.controller.dropDownHearderHeight = size.height + position.dy;
//        widget.controller.dropDownHearderHeight = dropDownItemRenderBox.size.height;

        if (widget.controller.isShow) {
          widget.controller.hide();
        } else {
          widget.controller.show(index);
        }
        if (widget.onItemTap != null) {
          widget.onItemTap(index);
        }
        setState(() {});
      },
      child: Container(
        color: widget.color,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: Text(item.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: _isShowDropDownItemWidget
                              ? widget.dropDownStyle
                              : widget.style),
                    ),
                    Icon(
                        !_isShowDropDownItemWidget
                            ? item.iconData ?? Icons.arrow_drop_down
                            : item.iconData ?? Icons.arrow_drop_up,
                        color: _isShowDropDownItemWidget
                            ? widget.iconDropDownColor
                            : widget.iconColor,
                        size: item.iconSize ?? widget.iconSize),
                  ]),
            ),
            index == widget.items.length - 1
                ? Container()
                : Container(
                    height: widget.dividerHeight,
                    decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide(
                                color: widget.dividerColor, width: 1))))
          ],
        ),
      ),
    );
  }
}

class DropDownHeaderItem {
  final String title;
  final IconData iconData;
  final double iconSize;

  DropDownHeaderItem(
    this.title, {
    this.iconData,
    this.iconSize,
  });
}
