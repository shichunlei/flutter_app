import 'package:flutter/material.dart';
import 'package:flutter_app/baixing_life/db/goods_provider.dart';
import 'package:flutter_app/baixing_life/page/details_page.dart';
import 'package:flutter_app/bean/goods.dart';
import 'package:flutter_app/ui/image_load_view.dart';
import 'package:flutter_app/utils/route_util.dart';

class ItemFloorGoods extends StatelessWidget {
  final Goods goods;
  final GoodsPrivider provider;
  final double height;
  final double width;

  ItemFloorGoods(this.goods, {Key key, this.provider, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        child: GestureDetector(
            child: ImageLoadView('${goods.comPic}'),
            onTap: () => pushNewPage(
                context,
                Hero(
                    tag: goods.goodsId,
                    child: DetailsPage(goods.goodsId, provider: provider)))));
  }
}
