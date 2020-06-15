import 'package:flutter/material.dart';
import 'package:flutter_app/store/index.dart';

import '../../page_index.dart';
import '../index.dart';

class ItemCartGoods extends StatelessWidget {
  final Goods goods;

  ItemCartGoods(this.goods, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = Store.value<ShoppingCartModel>(context);

    return GestureDetector(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
        child: Row(
          children: <Widget>[
            GestureDetector(
                child: Row(children: <Widget>[
                  Icon(
                      goods.isChecked == 1
                          ? CustomIcon.check
                          : CustomIcon.normal,
                      size: 20,
                      color: goods.isChecked == 1 ? Colors.red : Colors.grey),
                  Hero(
                      tag: goods.goodsId,
                      child: ImageLoadView('${goods.comPic}',
                          height: 80.0, width: 80.0))
                ]),
                onTap: () => state.toggleCheckGoods(goods)),
            Gaps.hGap8,
            Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('${goods.goodsName}', maxLines: 2),
                    Gaps.vGap8,
                    CartAmountView(goods: goods)
                  ]),
            ),
            Gaps.hGap8,
            Column(
                children: <Widget>[
                  Text('￥ ${goods.presentPrice}',
                      style: TextStyle(color: Colors.black, fontSize: 16.0)),
                  Text('￥ ${goods.oriPrice}',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                          decoration: TextDecoration.lineThrough)),
                  GestureDetector(
                      child: Icon(Icons.delete),
                      onTap: () => state.deleteCartGoods(goods.goodsId))
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end)
          ],
        ),
      ),
      onTap: () => pushNewPage(
        context,
        DetailsPage(goods.goodsId),
      ),
    );
  }
}
