import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_app/xianyu/ui/item.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

List<IntSize> _createSizes(int count) {
  Random rnd = Random();
  return List.generate(
    count,
    (i) => IntSize(rnd.nextInt(500) + 200, rnd.nextInt(800) + 200),
  );
}

class StaggeredViewPage extends StatefulWidget {
  @override
  _StaggeredViewPageState createState() => _StaggeredViewPageState();
}

class _StaggeredViewPageState extends State<StaggeredViewPage> {
  static const int _kItemCount = 1000;
  final List<IntSize> _sizes = _createSizes(_kItemCount).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('StaggeredView'),
      ),
      body: StaggeredGridView.countBuilder(
        primary: false,
        crossAxisCount: 4,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        itemBuilder: (context, index) =>
            Item(index: index, size: _sizes[index]),
        staggeredTileBuilder: (index) => StaggeredTile.fit(2),
        itemCount: _kItemCount,
      ),
    );
  }
}
