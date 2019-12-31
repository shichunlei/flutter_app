import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class ItemHomeFloor extends StatelessWidget {
  final FloorBean floor;

  ItemHomeFloor({Key key, this.floor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(10.0),
              child: GestureDetector(
                  onTap: () {
                    /// TODO 跳转商品列表页？
                  },
                  child: ImageLoadView(
                    '${floor.floorPic.pictureAddress}',
                    width: Utils.width - 20,
                    height: (Utils.width - 20) * 9 / 35,
                  ))),
          Container(
              height: Utils.width / 2,
              child: Row(children: <Widget>[
                ItemFloorGoods(floor.floor[0].goodsId, floor.floor[0].comPic,
                    width: Utils.width / 2),
                Container(
                    width: Utils.width / 2,
                    child: Column(children: <Widget>[
                      ItemFloorGoods(
                          floor.floor[1].goodsId, floor.floor[1].comPic,
                          height: Utils.width / 4),
                      ItemFloorGoods(
                          floor.floor[2].goodsId, floor.floor[2].comPic,
                          height: Utils.width / 4)
                    ]))
              ])),
          Container(
              height: Utils.width / 4,
              child: Row(children: <Widget>[
                ItemFloorGoods(floor.floor[3].goodsId, floor.floor[3].comPic,
                    width: Utils.width / 2),
                ItemFloorGoods(floor.floor[4].goodsId, floor.floor[4].comPic,
                    width: Utils.width / 2)
              ]))
        ],
      ),
    );
  }
}
