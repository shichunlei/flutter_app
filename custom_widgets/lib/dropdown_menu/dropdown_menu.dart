import 'package:flutter/material.dart';

import 'dropdown_menu_controller.dart';

export 'dropdown_menu_controller.dart';
export 'dropdown_header.dart';

class DropdownMenuBuilder {
  final Widget dropDownWidget;
  final double dropDownHeight;

  DropdownMenuBuilder(
      {@required this.dropDownWidget, @required this.dropDownHeight});
}

class DropDownMenu extends StatefulWidget {
  final DropdownMenuController controller;
  final List<DropdownMenuBuilder> menus;
  final int animationMilliseconds;

  const DropDownMenu(
      {Key key,
      @required this.controller,
      @required this.menus,
      this.animationMilliseconds = 500})
      : super(key: key);

  @override
  createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu>
    with SingleTickerProviderStateMixin {
  bool _isShowDropDownItemWidget = false;
  bool _isShowMask = false;

  Animation<double> _animation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(_onController);
    _controller = AnimationController(
        duration: Duration(milliseconds: widget.animationMilliseconds),
        vsync: this);
  }

  _onController() {
    debugPrint(
        '_DropDownMenuState._onController ${widget.controller.menuIndex}');

    _showDropDownItemWidget();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('_DropDownMenuState.build');
    _controller.duration = Duration(milliseconds: widget.animationMilliseconds);
    return _buildDropDownWidget();
  }

  dispose() {
    _controller.dispose();
    super.dispose();
  }

  _showDropDownItemWidget() {
    int menuIndex = widget.controller.menuIndex;
    if (menuIndex >= widget.menus.length || widget.menus[menuIndex] == null) {
      return;
    }
    _isShowDropDownItemWidget = !_isShowDropDownItemWidget;
    _isShowMask = !_isShowMask;

    _animation = Tween(begin: 0.0, end: widget.menus[menuIndex].dropDownHeight)
        .animate(_controller)
          ..addListener(() {
            setState(() {});
          });

    if (_animation.status == AnimationStatus.completed) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  _hideDropDownItemWidget() {
    _isShowDropDownItemWidget = !_isShowDropDownItemWidget;
    _isShowMask = !_isShowMask;
    _controller.reverse();
  }

  Widget _mask() {
    if (_isShowMask) {
      return GestureDetector(
        onTap: () {
          _hideDropDownItemWidget();
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.black54,
        ),
      );
    } else {
      return Container(height: 0);
    }
  }

  Widget _buildDropDownWidget() {
    int menuIndex = widget.controller.menuIndex;

    return Positioned(
        width: MediaQuery.of(context).size.width,
        top: widget.controller.dropDownHeaderHeight,
        left: 0,
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              height: _animation == null ? 0 : _animation.value,
              child: widget.menus[menuIndex].dropDownWidget,
            ),
            _mask()
          ],
        ));
  }
}
