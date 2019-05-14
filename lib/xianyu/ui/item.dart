import 'package:flutter/material.dart';
import 'package:flutter_app/ui/image_load_view.dart';

class Item extends StatelessWidget {
  const Item({Key key, this.index, this.size}) : super(key: key);

  final IntSize size;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Center(
                child: ImageLoadView(
                    'https://picsum.photos/${size.width}/${size.height}/'),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Image number $index',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Width: ${size.width}',
                  style: const TextStyle(color: Colors.grey),
                ),
                Text(
                  'Height: ${size.height}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class IntSize {
  const IntSize(this.width, this.height);

  final int width;
  final int height;
}