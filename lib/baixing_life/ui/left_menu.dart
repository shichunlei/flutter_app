import 'package:flutter/material.dart';
import 'package:flutter_app/res/colors.dart';
import 'package:flutter_app/store/index.dart';

import '../index.dart';

class LeftMenu extends StatefulWidget {
  final List<GoodsCategory> category;
  final GlobalKey<RightListViewState> rightKey;

  const LeftMenu({Key key, @required this.category, this.rightKey})
      : super(key: key);

  @override
  createState() => LeftMenuState();
}

class LeftMenuState extends State<LeftMenu> {
  double itemHeight = 44.0;

  @override
  Widget build(BuildContext context) {
    var provider = Store.value<BaixingModel>(context, listen: false);

    return Expanded(
        child: ListView.builder(
            padding: EdgeInsets.only(top: 0),
            itemBuilder: (context, index) {
              return InkWell(
                  child: Container(
                      color: index == provider.categoryIndex
                          ? Colors.white
                          : Colors.transparent,
                      height: itemHeight,
                      alignment: Alignment.center,
                      child: Text('${widget.category[index].mallCategoryName}',
                          style: TextStyle(
                              fontSize:
                                  index == provider.categoryIndex ? 16 : 14,
                              color: index == provider.categoryIndex
                                  ? Color.fromRGBO(132, 95, 63, 1.0)
                                  : grey6Color))),
                  onTap: () {
                    provider.setCategories(index, 0);
                    widget.rightKey.currentState.refreshView(
                        1, 0, widget.category[provider.categoryIndex]);
                    setState(() {});
                  });
            },
            itemCount: widget.category.length));
  }
}
