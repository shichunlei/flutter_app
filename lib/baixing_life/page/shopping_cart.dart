import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class ShoppingCartPage extends StatefulWidget {
  final String title;
  final GoodsProvider provider;

  ShoppingCartPage(this.title, this.provider, {Key key}) : super(key: key);

  @override
  createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage>
    with AutomaticKeepAliveClientMixin {
  List<Goods> products = [];

  @override
  bool get wantKeepAlive => true;

  /// 选中的商品中暑
  int clickNumber = 0;

  /// 选种商品的总价
  double clickTotalPrice = 0.0;

  /// 购物车商品总数（既包括选中也包括未选中）
  int totalNumber = 0;

  /// 购物车商品总价（既包括选中也包括未选中）
  double totalPrice = 0.0;

  /// 购物车商品是否全选中
  bool isCheckAll = false;

  @override
  void initState() {
    super.initState();

    getCartProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: Column(children: <Widget>[
          ToolBar(title: '${widget.title}', backgroundColor: Colors.indigo),
          Expanded(
              child: Container(
                  child: products.isEmpty
                      ? EmptyShopCart()
                      : Column(children: <Widget>[
                          _buildCartGoodsList(),
                          _buildCartBottom()
                        ])))
        ]));
  }

  Widget _buildCartGoodsList() {
    List<Widget> children = [];

    products.forEach((product) {
      int index = products.indexOf(product);
      children.add(ItemCartGoods(product,
          isChecked: products[index].isChecked == 1,
          checkOnTap: () => isCheckGoods(products[index]),
          deleteOnTap: () => deleteCartGoods(index),
          provider: widget.provider,
          onTap: () => pushNewPage(
              context, DetailsPage(product.goodsId, provider: widget.provider)),
          amount: products[index].amount,
          minusOnPressed: () => products[index].amount > 1
              ? minusGoodsAmount(products[index])
              : null,
          addOnPressed: () => addGoodsAmount(products[index])));
    });
    goodsNumberOrPrice();
    children.add(Container(
        color: Colors.white,
        padding: EdgeInsets.all(8.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('共$totalNumber件商品'),
              Text('小计：￥$totalPrice')
            ])));

    return Expanded(
        child: ListView(
            padding: EdgeInsets.only(top: 0),
            children: children,
            physics: const BouncingScrollPhysics()));
  }

  Widget _buildCartBottom() {
    return Container(
        alignment: Alignment.center,
        color: Colors.white,
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 8.0, right: 8.0),
        child: Row(children: <Widget>[
          GestureDetector(
              onTap: () => checkAllGoods(),
              child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Icon(isCheckAll ? CustomIcon.check : CustomIcon.normal,
                    size: 20, color: isCheckAll ? Colors.red : Colors.grey),
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
                  Text('￥$clickTotalPrice', style: TextStyle(color: Colors.red))
                ]),
                Text('满10元免配送费，预购免配送',
                    style: TextStyle(fontSize: 12.0, color: Colors.grey))
              ])),
          Gaps.hGap10,
          RaisedButton(
              color: Colors.red,
              onPressed: clickTotalPrice > 0.0
                  ? () {
                      /// TODO 去结算
                    }
                  : null,
              child: Text('结算($clickNumber)',
                  style: TextStyle(color: Colors.white)))
        ]));
  }

  void getCartProducts() async {
    products = await widget.provider.getGoodsList();

    goodsNumberOrPrice();
  }

  void deleteCartGoods(int index) async {
    String goodsId = products[index].goodsId;
    products.removeAt(index);
    goodsNumberOrPrice();
    widget.provider.deleteGoods(goodsId);
  }

  void checkAllGoods() async {
    // 全选中
    if (isCheckAll) {
      setState(() {
        isCheckAll = false;
        clickTotalPrice = 0.0;
        clickNumber = 0;
      });

      products.forEach((goods) {
        goods.isChecked = 0;
        widget.provider.insertOrReplaceToDB(goods);
      });

      goodsNumberOrPrice();
    }
    // 非全选中
    else {
      setState(() {
        isCheckAll = true;
        clickNumber = products.length;
      });
      clickTotalPrice = 0.0;
      products.forEach((goods) {
        goods.isChecked = 1;
        setState(() {});
        widget.provider.insertOrReplaceToDB(goods);
      });

      goodsNumberOrPrice();
    }
  }

  /// 重新计算选中商品总数、选种商品总价、所有商品总数、所有商品总价
  void goodsNumberOrPrice() {
    clickTotalPrice = 0.0;
    clickNumber = 0;
    totalNumber = 0;
    totalPrice = 0.0;
    products.forEach((goods) {
      if (goods.isChecked == 1) {
        clickTotalPrice += goods.presentPrice * goods.amount;
        clickNumber += goods.amount;
      }
      totalNumber += goods.amount;
      totalPrice += goods.presentPrice * goods.amount;
    });

    /// 是否全部选中
    isCheckedAll();
    setState(() {});
  }

  void isCheckGoods(Goods goods) async {
    /// 将购物车商品选中状态更改为相反的状态
    goods.isChecked = goods.isChecked == 1 ? 0 : 1;

    goodsNumberOrPrice();

    widget.provider.insertOrReplaceToDB(goods);
  }

  void isCheckedAll() {
    isCheckAll = clickNumber == totalNumber && totalNumber > 0;
  }

  void minusGoodsAmount(Goods goods) {
    goods.amount = goods.amount - 1;
    goodsNumberOrPrice();
    widget.provider.insertOrReplaceToDB(goods);
  }

  void addGoodsAmount(Goods goods) {
    goods.amount = goods.amount + 1;
    goodsNumberOrPrice();
    widget.provider.insertOrReplaceToDB(goods);
  }
}
