import 'package:flutter/material.dart';
import 'package:flutter_app/baixing_life/index.dart';

import '../../page_index.dart';

class ItemOrderGoods extends StatelessWidget {
  final SubOrderBean order;

  ItemOrderGoods({Key key, @required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.grey[200],
        child: InkWell(
            child: Container(
                margin: EdgeInsets.all(8.0),
                child: Row(children: <Widget>[
                  ImageLoadView('${order.image}', height: 80, width: 80),
                  Expanded(
                      child: Container(
                          padding: EdgeInsets.all(8.0),
                          child: Text('${order.name}',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          alignment: Alignment.topLeft)),
                  Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: Text('￥${order.payment}',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold))),
                        Text('x ${order.buyNum}')
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end)
                ], crossAxisAlignment: CrossAxisAlignment.start)),
            onTap: () => pushNewPage(context, DetailsPage(order.goodsId))));
  }
}
