import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class ItemGoodsGrid extends StatelessWidget {
  final Goods goods;
  final GoodsProvider provider;

  ItemGoodsGrid(this.goods, {Key key, this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: GestureDetector(
            child: Column(children: <Widget>[
              Hero(tag: goods.goodsId, child: ImageLoadView('${goods.comPic}')),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text('${goods.goodsName}',
                      style: TextStyle(color: Colors.pink),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1)),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Row(children: <Widget>[
                    Text('￥${goods.presentPrice}',
                        style: TextStyle(fontSize: 13.0)),
                    Text('￥${goods.oriPrice}',
                        style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 12.0,
                            decoration: TextDecoration.lineThrough))
                  ], mainAxisAlignment: MainAxisAlignment.spaceBetween))
            ]),
            onTap: () => pushNewPage(
                context, DetailsPage(goods.goodsId, provider: provider))));
  }
}
