import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../baixing_page.dart';

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
            child: Text('随便逛逛', style: TextStyle(fontSize: 18)),
            color: Colors.red,
            halfRadius: true,
            width: 120,
            height: 36,
          )
        ]));
  }
}
