import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class ItemCartGoods extends StatelessWidget {
  final VoidCallback onTap;
  final Goods goods;
  final VoidCallback deleteOnTap;
  final GoodsProvider provider;
  final VoidCallback checkOnTap;
  final bool isChecked;
  final int amount;
  final VoidCallback addOnPressed;
  final VoidCallback minusOnPressed;

  ItemCartGoods(this.goods,
      {Key key,
      this.deleteOnTap,
      this.provider,
      this.onTap,
      this.checkOnTap,
      this.isChecked = false,
      this.amount = 1,
      this.addOnPressed,
      this.minusOnPressed})
      : assert(isChecked != null),
        assert(amount != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: Row(children: <Widget>[
                GestureDetector(
                    child: Row(children: <Widget>[
                      Icon(isChecked ? CustomIcon.check : CustomIcon.normal,
                          size: 20,
                          color:
                              goods.isChecked == 1 ? Colors.red : Colors.grey),
                      Hero(
                          tag: goods.goodsId,
                          child: ImageLoadView('${goods.comPic}',
                              height: 80.0, width: 80.0))
                    ]),
                    onTap: checkOnTap),
                Gaps.hGap8,
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('${goods.goodsName}', maxLines: 2),
                        Gaps.vGap8,
                        CartAmountView(
                            amount: amount,
                            addOnPressed: addOnPressed,
                            minusOnPressed: minusOnPressed)
                      ]),
                ),
                Gaps.hGap8,
                Column(
                    children: <Widget>[
                      Text('￥ ${goods.presentPrice}',
                          style:
                              TextStyle(color: Colors.black, fontSize: 16.0)),
                      Text('￥ ${goods.oriPrice}',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.0,
                              decoration: TextDecoration.lineThrough)),
                      GestureDetector(
                          child: Icon(Icons.delete), onTap: deleteOnTap)
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end)
              ]),
            ),
            Container(height: 0.5, color: Colors.grey[200])
          ],
        ),
        onTap: onTap);
  }
}
