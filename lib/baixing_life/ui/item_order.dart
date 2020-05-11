import 'package:flutter/material.dart';
import 'package:flutter_app/baixing_life/index.dart';
import 'package:flutter_app/page_index.dart';

class ItemOrder extends StatelessWidget {
  final OrderBean order;

  ItemOrder({Key key, @required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        clipBehavior: Clip.antiAlias,
        color: Colors.white,
        child: Column(children: [
          Material(
              type: MaterialType.transparency,
              child: InkWell(
                  onTap: () => pushNewPage(context,
                      ShopInfoPage(id: order.shopId, name: order.shopName)),
                  child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: Row(children: <Widget>[
                        Icon(Icons.home),
                        Gaps.hGap10,
                        Text('${order.shopName}'),
                        Spacer(),
                        Icon(Icons.arrow_right)
                      ])))),
          ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              primary: false,
              itemBuilder: (_, index) =>
                  ItemOrderGoods(order: order.subOrder[index]),
              itemCount: order.subOrder.length,
              separatorBuilder: (BuildContext context, int index) =>
                  Gaps.vGap(1)),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                  children: <Widget>[Text('下单时间：'), Text('${order.orderTime}')],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween)),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(children: <Widget>[
                Text('总价：'),
                Text('￥${order.totalPayment}')
              ], mainAxisAlignment: MainAxisAlignment.spaceBetween)),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                  children: <Widget>[Text('优惠：'), Text('￥${order.totalFee}')],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween)),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(children: <Widget>[
                Text('实付金额：'),
                Text('￥${order.totalPayment - order.totalFee}',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold))
              ], mainAxisAlignment: MainAxisAlignment.spaceBetween)),
          Visibility(
              visible: order.settlementTime != '',
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(children: <Widget>[
                    Text('完成时间：'),
                    Text('${order.settlementTime}')
                  ], mainAxisAlignment: MainAxisAlignment.spaceBetween))),
        ]));
  }
}
