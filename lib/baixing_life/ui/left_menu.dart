import 'package:flutter/material.dart';

import '../index.dart';

class LeftMenu extends StatefulWidget {
  final int index;
  final List<Category> category;
  final GlobalKey<RightListViewState> rightKey;

  LeftMenu({Key key, @required this.category, this.index, this.rightKey})
      : super(key: key);

  @override
  createState() => LeftMenuState();
}

class LeftMenuState extends State<LeftMenu> {
  int currentItemIndex;

  double itemHeight = 44.0;

  @override
  void initState() {
    super.initState();

    currentItemIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            padding: EdgeInsets.only(top: 0),
            itemBuilder: (context, index) {
              return InkWell(
                  child: Container(
                      color: index == currentItemIndex
                          ? Colors.white
                          : Colors.transparent,
                      height: itemHeight,
                      alignment: Alignment.center,
                      child: Text('${widget.category[index].mallCategoryName}',
                          style: TextStyle(
                              fontSize: index == currentItemIndex ? 16 : 14,
                              color: index == currentItemIndex
                                  ? Color.fromRGBO(132, 95, 63, 1.0)
                                  : Color(0xFF666666)))),
                  onTap: () {
                    currentItemIndex = index;
                    widget.rightKey.currentState
                        .refreshView(1, 0, widget.category[currentItemIndex]);
                    setState(() {});
                  });
            },
            itemCount: widget.category.length));
  }
}
