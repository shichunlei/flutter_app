import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class ItemCartGoods extends StatefulWidget {
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
  createState() => _ItemCartGoodsState();
}

class _ItemCartGoodsState extends State<ItemCartGoods> {
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
                      Icon(
                          widget.isChecked
                              ? CustomIcon.check
                              : CustomIcon.normal,
                          size: 20,
                          color: widget.goods.isChecked == 1
                              ? Colors.red
                              : Colors.grey),
                      Hero(
                          tag: widget.goods.goodsId,
                          child: ImageLoadView('${widget.goods.comPic}',
                              height: 80.0, width: 80.0))
                    ]),
                    onTap: widget.checkOnTap),
                SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('${widget.goods.goodsName}', maxLines: 2),
                        SizedBox(height: 10.0),
                        CartAmountView(
                            amount: widget.amount,
                            addOnPressed: widget.addOnPressed,
                            minusOnPressed: widget.minusOnPressed)
                      ]),
                ),
                SizedBox(width: 8.0),
                Column(
                    children: <Widget>[
                      Text('￥ ${widget.goods.presentPrice}',
                          style:
                              TextStyle(color: Colors.black, fontSize: 16.0)),
                      Text('￥ ${widget.goods.oriPrice}',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.0,
                              decoration: TextDecoration.lineThrough)),
                      GestureDetector(
                          child: Icon(Icons.delete), onTap: widget.deleteOnTap)
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end)
              ]),
            ),
            Container(height: 0.5, color: Colors.grey[200])
          ],
        ),
        onTap: widget.onTap);
  }
}
