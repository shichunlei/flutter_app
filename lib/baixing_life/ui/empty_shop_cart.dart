import 'package:flutter/material.dart';
import 'package:flutter_app/baixing_life/index.dart';
import 'package:flutter_app/utils/route_util.dart';

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
                child:
                    Icon(Icons.shopping_cart, color: Colors.grey, size: 40.0),
                backgroundColor: Colors.grey[100]),
            SizedBox(height: 15),
            Text('购物车还空着，快去挑选商品吧'),
            SizedBox(height: 15),
            RaisedButton(
                onPressed: () => pushReplacement(context, IndexPage()),
                child: Text('随便逛逛', style: TextStyle(color: Colors.white)),
                color: Colors.red,
                shape: const StadiumBorder())
          ]),
    );
  }
}
