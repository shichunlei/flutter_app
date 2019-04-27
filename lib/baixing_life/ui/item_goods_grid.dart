import 'package:flutter/material.dart';
import 'package:flutter_app/baixing_life/db/goods_provider.dart';
import 'package:flutter_app/baixing_life/page/details_page.dart';
import 'package:flutter_app/bean/goods.dart';
import 'package:flutter_app/ui/image_load_view.dart';
import 'package:flutter_app/utils/route_util.dart';

class ItemGoodsGrid extends StatelessWidget {
  final Goods goods;
  final GoodsPrivider provider;

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
