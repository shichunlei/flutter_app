import 'package:flutter/material.dart';
import 'package:flutter_app/store/index.dart';

import '../index.dart';

class CartAmountView extends StatelessWidget {
  final Goods goods;

  CartAmountView({Key key, @required this.goods}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = Store.value<ShoppingCartModel>(context);
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
              child: Icon(Icons.remove,
                  size: 25,
                  color: goods.number > 1 ? Colors.black : Colors.grey),
              onTap: goods.number > 1
                  ? () => state.minusGoodsAmount(goods)
                  : null),
          Container(width: 1.0, color: Colors.grey, height: 25),
          Container(
              child: Text(' ${goods.number} '),
              width: 35.0,
              alignment: Alignment.center),
          Container(width: 1.0, color: Colors.grey, height: 25),
          GestureDetector(
              child: Icon(Icons.add, size: 25),
              onTap: () => state.addGoodsAmount(goods))
        ],
      ),
    );
  }
}
