import 'dart:io';

import 'package:flutter/material.dart';

enum ImageType { network, assets, localFile }

class ImageLoadView extends StatelessWidget {
  /// 图片URL
  final String path;

  /// 宽
  final double width;

  /// 高
  final double height;

  /// 填充效果
  final BoxFit fit;

  /// 加载中图片
  final String placeholder;

  /// 点击事件
  final VoidCallback onPressed;

  /// 圆角
  final BorderRadius borderRadius;

  ///
  final ImageType imageType;

  ImageLoadView(
    this.path, {
    Key key,
    this.width,
    this.height,
    this.fit: BoxFit.fill,
    this.onPressed,
    this.borderRadius: const BorderRadius.all(Radius.circular(0.0)),
    this.placeholder: "images/loading.png",
    this.imageType: ImageType.network,
  })  : assert(path != null),
        assert(fit != null),
        assert(borderRadius != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    switch (imageType) {
      case ImageType.network:
        imageWidget = FadeInImage(
            placeholder: AssetImage(placeholder),
            image: NetworkImage(path),
            height: height,
            width: width,
            fit: fit);
        break;
      case ImageType.assets:
        imageWidget = FadeInImage(
            placeholder: AssetImage(placeholder),
            image: AssetImage(path),
            height: height,
            width: width,
            fit: fit);
        break;
      case ImageType.localFile:
        imageWidget = FadeInImage(
            placeholder: AssetImage(placeholder),
            image: FileImage(File(path)),
            height: height,
            width: width,
            fit: fit);
        break;
      default:
        imageWidget = Image.asset(placeholder);
        break;
    }

    return InkWell(
        onTap: onPressed,
        child: ClipRRect(borderRadius: borderRadius, child: imageWidget));
  }
}
