import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/utils/log_util.dart';
import 'package:flutter_app/xianyu/ui/item.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class BottomGridView extends StatefulWidget {
  final int index;

  BottomGridView({Key key, this.index}) : super(key: key);

  @override
  createState() => _BottomGridViewState();
}

class _BottomGridViewState extends State<BottomGridView> {
  List<IntSize> _sizes = [];

  @override
  void initState() {
    super.initState();

    LogUtil.v('---------------${widget.index}');
  }

  @override
  Widget build(BuildContext context) {
    getListData(widget.index);

    return StaggeredGridView.countBuilder(
        shrinkWrap: true,
        primary: false,
        crossAxisCount: 4,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        itemBuilder: (context, index) =>
            Item(index: index, size: _sizes[index]),
        staggeredTileBuilder: (index) => StaggeredTile.fit(2),
        itemCount: 5 * (widget.index + 1));
  }

  List<IntSize> _createSizes(int count) {
    Random rnd = Random();
    return List.generate(
      count,
      (i) => IntSize(rnd.nextInt(500) + 200, rnd.nextInt(800) + 200),
    );
  }

  void getListData(int index) async {
    _sizes.clear();
    setState(() {});
    LogUtil.v('$index==========================================');
    _sizes = _createSizes(5 * (index + 1)).toList();
    setState(() {});
  }
}
