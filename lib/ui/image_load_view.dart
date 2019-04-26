import 'dart:typed_data';

import 'package:flutter/material.dart';

class ImageLoadView extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final BoxFit fit;
  final dynamic placeholder;

  ImageLoadView(
    this.imageUrl, {
    Key key,
    this.width,
    this.height,
    this.fit = BoxFit.fill,
    this.placeholder = const AssetImage("images/wallfy.png"),
  })  : assert(imageUrl != null),
        assert(fit != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return (placeholder is Uint8List)
        ? FadeInImage.memoryNetwork(
            placeholder: placeholder,
            image: imageUrl,
            height: height,
            width: width,
            fit: fit,
          )
        : (placeholder is ImageProvider)
            ? FadeInImage(
                placeholder: placeholder,
                image: NetworkImage(imageUrl),
                height: height,
                width: width,
                fit: fit,
              )
            : null;
  }
}
