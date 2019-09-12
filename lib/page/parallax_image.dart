import 'package:flutter/material.dart';
import 'package:parallax_image/parallax_image.dart';

class ParallaxImageDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: Text('视差图片效果')),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Horizontal scroll parallax',
            ),
          ),
          Container(
            constraints: const BoxConstraints(maxHeight: 200.0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: _buildHorizontalChild,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Text('Vertical scroll parallax'),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: _buildVerticalChild,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildVerticalChild(BuildContext context, int index) {
    index++;
    if (index > 7) return null;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: ParallaxImage(
        extent: 150.0,
        image: NetworkImage(
          'https://github.com/pulyaevskiy/parallax-image/blob/master/example/images/img$index.jpg?raw=true',
        ),
        child: Text('图片$index'),
      ),
    );
  }

  Widget _buildHorizontalChild(BuildContext context, int index) {
    index++;
    if (index > 7) return null;
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: ParallaxImage(
        extent: 100.0,
        image: NetworkImage(
          'https://github.com/pulyaevskiy/parallax-image/blob/master/example/images/img$index.jpg?raw=true',
        ),
      ),
    );
  }
}
