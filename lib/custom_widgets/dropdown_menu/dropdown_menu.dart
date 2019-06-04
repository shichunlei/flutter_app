import 'package:flutter/material.dart';

import 'dropdown_menu_controller.dart';

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
  double _screenWidth;
  double _screenHeight;
  int _menuCount;
  bool _isShowMask = false;

  Animation<double> _animation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(_onController);
    _controller = new AnimationController(
        duration: Duration(milliseconds: widget.animationMilliseconds),
        vsync: this);
  }

  _onController() {
    debugPrint('_DropDownMenuState._onController ${widget.controller.menuIndex}');

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
//    final RenderBox dropDownItemRenderBox = _keyDropDownItem.currentContext.findRenderObject();
//
//    _dropDownHeight = dropDownItemRenderBox.size.height;
    _isShowDropDownItemWidget = !_isShowDropDownItemWidget;
    _isShowMask = !_isShowMask;

    _animation =
        new Tween(begin: 0.0, end: widget.menus[menuIndex].dropDownHeight)
            .animate(_controller)
              ..addListener(() {
                //这行如果不写，没有动画效果
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
          color: Color.fromRGBO(0, 0, 0, 0.1),
        ),
      );
    } else {
      return Container(height: 0);
    }
  }

  Widget _buildDropDownWidget() {
//    RenderBox renderBoxRed;
//    double top = 0;
//    if (_dropDownHeight != 0) {
//      renderBoxRed = _keyFilter.currentContext.findRenderObject();
//      top = renderBoxRed.size.height;
//    }
//    print('SearchResultListState._buildDrapDownWidget ${renderBoxRed.size}' );
    int menuIndex = widget.controller.menuIndex;

    return Positioned(
        width: MediaQuery.of(context).size.width,
        top: widget.controller.dropDownHearderHeight,
//    top: 50,
        left: 0,
//        height: 20,
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
//                color: Colors.white,
//                height: animation.value,
              height: _animation == null ? 0 : _animation.value,

              child: widget.menus[menuIndex].dropDownWidget,
//              child: Container(
//                color: Colors.red,
//                height: 200,
//                width: MediaQuery.of(context).size.width,
//              ),
            ),
            _mask()
          ],
        )
//      height: _animation == null ? 0 : _animation.value,
//
//      child: Container(
////      color: Color.fromRGBO(0, 0, 0, 0.1),
//      color: Colors.blue,
//        width: MediaQuery.of(context).size.width,
////                color: Colors.white,
//                height: MediaQuery.of(context).size.height,
//
//        child: _dropDownItem,
//      ),
        );
  }
}
