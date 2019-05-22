import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/image_load_view.dart';
import 'package:flutter_app/utils/utils.dart';
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

class Item extends StatelessWidget {
  const Item({Key key, this.index, this.size}) : super(key: key);

  final IntSize size;
  final int index;

  @override
  Widget build(BuildContext context) {
    double itemWidth = Utils.width / 2 - 4;

    return Card(
      child: Column(children: <Widget>[
        Stack(children: <Widget>[
          Center(
              child: ImageLoadView(
                  'https://picsum.photos/${size.width}/${size.height}/',
                  width: itemWidth,
                  height: itemWidth * size.height / size.width)),
        ]),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(children: <Widget>[
            Text('Image number $index',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Text('Width: ${size.width}',
                style: const TextStyle(color: Colors.grey)),
            Text('Height: ${size.height}',
                style: const TextStyle(color: Colors.grey)),
          ]),
        )
      ]),
    );
  }
}

class IntSize {
  const IntSize(this.width, this.height);

  final int width;
  final int height;
}
