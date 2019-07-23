import 'package:flutter/material.dart';

import '../../page_index.dart';

class EmptyShopCart extends StatelessWidget {
  EmptyShopCart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          CircleAvatar(
              radius: 40.0,
              child: Icon(Icons.shopping_cart, color: Colors.grey, size: 40.0),
              backgroundColor: Colors.grey[100]),
          Gaps.vGap15,
          Text('购物车还空着，快去挑选商品吧'),
          Gaps.vGap15,
          Button(
            onPressed: () => pushReplacement(context, IndexPage()),
            text: '随便逛逛',
            color: Colors.red,
            borderRadius: 24,
            width: 80,
            height: 36,
          )
        ]));
  }
}
