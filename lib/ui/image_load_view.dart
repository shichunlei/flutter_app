import 'dart:typed_data';

import 'package:flutter/material.dart';

class ImageLoadView extends StatelessWidget {
  /// 图片URL
  final String imageUrl;

  /// 宽
  final double width;

  /// 高
  final double height;

  /// 填充效果
  final BoxFit fit;

  /// 加载中图片
  final dynamic placeholder;

  /// 点击事件
  final VoidCallback onPressed;

  /// 圆角
  final BorderRadius borderRadius;

  ImageLoadView(this.imageUrl,
      {Key key,
      this.width,
      this.height,
      this.fit = BoxFit.fill,
      this.onPressed,
      this.borderRadius = const BorderRadius.all(Radius.circular(0.0)),
      this.placeholder = const AssetImage("images/wallfy.png")})
      : assert(imageUrl != null),
        assert(fit != null),
        assert(borderRadius != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed,
        child: ClipRRect(
            borderRadius: borderRadius,
            child: (placeholder is Uint8List)
                ? FadeInImage.memoryNetwork(
                    placeholder: placeholder,
                    image: imageUrl,
                    height: height,
                    width: width,
                    fit: fit)
                : (placeholder is ImageProvider)
                    ? FadeInImage(
                        placeholder: placeholder,
                        image: NetworkImage(imageUrl),
                        height: height,
                        width: width,
                        fit: fit)
                    : null));
  }
}
