import 'package:flutter/material.dart';
import 'package:flutter_app/store/index.dart';

import '../../page_index.dart';
import '../index.dart';

class ShoppingCartPage extends StatefulWidget {
  final String title;

  ShoppingCartPage(this.title, {Key key}) : super(key: key);

  @override
  createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text('${widget.title}'),
            backgroundColor: Colors.indigo),
        backgroundColor: Colors.grey[200],
        body: Store.value<ShoppingCartModel>(context).products.isEmpty
            ? EmptyShopCart()
            : Column(
                children: <Widget>[_buildCartGoodsList(), _buildCartBottom()]));
  }

  Widget _buildCartGoodsList() {
    var state = Store.value<ShoppingCartModel>(context);

    List<Widget> children = [];

    state.products.forEach((product) {
      children.add(ItemCartGoods(product));
    });
    children.add(Container(
        color: Colors.white,
        padding: EdgeInsets.all(8.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('共${state.totalNumber}件商品'),
              Text('小计：￥${state.totalPrice}')
            ])));

    return Expanded(
        child: ListView.separated(
      padding: EdgeInsets.only(top: 0),
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (BuildContext context, int index) =>
          Container(height: 0.5, color: Colors.grey[200]),
      itemCount: children.length,
      itemBuilder: (BuildContext context, int index) => children[index],
    ));
  }

  Widget _buildCartBottom() {
    var state = Store.value<ShoppingCartModel>(context);

    return Container(
        alignment: Alignment.center,
        color: Colors.white,
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 8.0, right: 8.0),
        child: Row(children: <Widget>[
          GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => state.toggleCheckAllGoods(),
              child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Icon(state.isCheckAll ? CustomIcon.check : CustomIcon.normal,
                    size: 20,
                    color: state.isCheckAll ? Colors.red : Colors.grey),
                Gaps.hGap5,
                Text('全选', style: TextStyle(color: Colors.black))
              ])),
          Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  Text('合计：', style: TextStyle(color: Colors.black)),
                  Text('￥${state.clickTotalPrice}',
                      style: TextStyle(color: Colors.red))
                ]),
                Text('满10元免配送费，预购免配送',
                    style: TextStyle(fontSize: 12.0, color: Colors.grey))
              ])),
          Gaps.hGap10,
          RaisedButton(
              color: Colors.red,
              onPressed: state.clickTotalPrice > 0.0
                  ? () {
                      /// TODO 去结算
                    }
                  : null,
              child: Text('结算(${state.clickNumber})',
                  style: TextStyle(color: Colors.white)))
        ]));
  }
}
