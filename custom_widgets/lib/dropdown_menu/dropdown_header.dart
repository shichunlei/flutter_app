import 'package:flutter/material.dart';
import 'dropdown_menu_controller.dart';

typedef OnItemTap<T> = void Function(T value);

class DropDownHeader extends StatefulWidget {
  final Color color;
  final double borderWidth;
  final Color borderColor;
  final TextStyle style;
  final TextStyle dropDownStyle;
  final double iconSize;
  final Color iconColor;
  final Color iconDropDownColor;

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
    this.style: const TextStyle(color: Color(0xFF666666), fontSize: 13),
    this.dropDownStyle,
    this.height: 50,
    this.iconColor: const Color(0xFFafada7),
    this.iconDropDownColor,
    this.iconSize: 20,
    this.borderWidth: 1,
    this.borderColor: const Color(0xFFeeede6),
    this.dividerHeight: 20,
    this.dividerColor: const Color(0xFFeeede6),
    this.onItemTap,
    this.color: Colors.white,
  }) : super(key: key);

  @override
  createState() => _DropDownHeaderState();
}

class _DropDownHeaderState extends State<DropDownHeader>
    with SingleTickerProviderStateMixin {
  bool _isShowDropDownItemWidget = false;
  GlobalKey _keyDropDownHeader = GlobalKey();

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(_onController);
  }

  _onController() {
    debugPrint('${widget.controller.menuIndex}');
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('_DropDownHeaderState.build');

    return Container(
      key: _keyDropDownHeader,
      height: widget.height,
      width: double.infinity,
      decoration: BoxDecoration(
        border:
            Border.all(color: widget.borderColor, width: widget.borderWidth),
      ),
      child: Row(
          children: widget.items.map<Widget>((item) => _menu(item)).toList()),
    );
  }

  dispose() {
    super.dispose();
  }

  _menu(DropDownHeaderItem item) {
    int index = widget.items.indexOf(item);
    int menuIndex = widget.controller.menuIndex;
    _isShowDropDownItemWidget = index == menuIndex && widget.controller.isShow;

    return Expanded(
      child: Material(
        color: widget.color,
        child: InkWell(
          onTap: () {
            final RenderBox overlay =
                widget.stackKey.currentContext.findRenderObject();

            final RenderBox dropDownItemRenderBox =
                _keyDropDownHeader.currentContext.findRenderObject();

            var position = dropDownItemRenderBox.localToGlobal(Offset.zero,
                ancestor: overlay);
            debugPrint("POSITION : $position ");
            var size = dropDownItemRenderBox.size;
            debugPrint("SIZE : $size");

            widget.controller.dropDownHeaderHeight = size.height + position.dy;

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
            height: double.infinity,
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
                                  ? widget.dropDownStyle ??
                                      TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 13)
                                  : widget.style),
                        ),
                        Icon(
                            !_isShowDropDownItemWidget
                                ? item.iconData ?? Icons.arrow_drop_down
                                : item.iconData ?? Icons.arrow_drop_up,
                            color: _isShowDropDownItemWidget
                                ? widget.iconDropDownColor ??
                                    Theme.of(context).primaryColor
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
