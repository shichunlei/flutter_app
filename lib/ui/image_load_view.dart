import 'package:flutter/material.dart';

class ImageLoadView extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final BoxFit fit;

  ImageLoadView(
    this.imageUrl, {
    Key key,
    this.width,
    this.height,
    this.fit = BoxFit.fill,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      placeholder: AssetImage("images/wallfy.png"),
      image: NetworkImage(imageUrl),
      height: height,
      width: width,
      fit: fit,
    );
  }
}
