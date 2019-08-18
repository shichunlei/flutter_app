import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class ItemFloorGoods extends StatelessWidget {
  final String goodsId;
  final String goodsImage;
  final GoodsProvider provider;
  final double height;
  final double width;

  ItemFloorGoods(this.goodsId, this.goodsImage,
      {Key key, this.provider, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        child: GestureDetector(
            child: Hero(tag: goodsId, child: ImageLoadView('$goodsImage')),
            onTap: () => pushNewPage(
                context, DetailsPage(goodsId, provider: provider))));
  }
}
