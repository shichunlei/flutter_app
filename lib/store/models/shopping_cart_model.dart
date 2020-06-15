import 'package:flutter/material.dart';
import 'package:flutter_app/baixing_life/db/goods_provider.dart';
import 'package:flutter_app/bean/baixing.dart';

class ShoppingCartModel extends ChangeNotifier {
  GoodsProvider provider;

  List<Goods> _products = [];

  List<Goods> get products => _products;

  ShoppingCartModel() {
    provider = GoodsProvider();
  }

  void refreshCartProducts() async {
    _products = await provider.getGoodsList();

    _totalPrice = 0.0;
    _totalNumber = 0;
    _clickTotalPrice = 0.0;
    _clickNumber = 0;
    _products.forEach((goods) {
      if (goods.isChecked == 1) {
        _clickTotalPrice += goods.presentPrice * goods.number;
        _clickNumber += goods.number;
      }
      _totalNumber += goods.number;
      _totalPrice += goods.presentPrice * goods.number;
    });

    _isCheckAll = _clickNumber == _totalNumber && _totalNumber > 0;

    refresh();
  }

  int _clickNumber = 0;

  /// 选中的商品中暑
  int get clickNumber => _clickNumber;

  double _clickTotalPrice = 0.0;

  /// 选种商品的总价
  double get clickTotalPrice => _clickTotalPrice;

  int _totalNumber = 0;

  /// 购物车商品总数（既包括选中也包括未选中）
  int get totalNumber => _totalNumber;

  double _totalPrice = 0.0;

  /// 购物车商品总价（既包括选中也包括未选中）
  double get totalPrice => _totalPrice;

  bool _isCheckAll = false;

  /// 购物车商品是否全选中
  bool get isCheckAll => _isCheckAll;

  /// 数量减1
  void minusGoodsAmount(Goods goods) async {
    goods.number = goods.number - 1;
    await provider.insertOrReplaceToDB(goods);

    refreshCartProducts();
  }

  /// 数量加1
  void addGoodsAmount(Goods goods) async {
    print(goods.number);

    goods.number = goods.number + 1;

    print(goods.number);

    await provider.insertOrReplaceToDB(goods);

    refreshCartProducts();
  }

  /// 选中要结算的商品
  void toggleCheckGoods(Goods goods) async {
    goods.isChecked = goods.isChecked == 1 ? 0 : 1;

    await provider.insertOrReplaceToDB(goods);

    refreshCartProducts();
  }

  /// 全选按钮
  void toggleCheckAllGoods() async {
    if (isCheckAll) {
      _products.forEach((goods) {
        goods.isChecked = 0;
        provider.insertOrReplaceToDB(goods);
      });
    } else {
      _products.forEach((goods) {
        goods.isChecked = 1;
        provider.insertOrReplaceToDB(goods);
      });
    }

    refreshCartProducts();
  }

  /// 删除购物车某商品
  void deleteCartGoods(String goodsId) async {
    await provider.deleteGoods(goodsId);

    refreshCartProducts();
  }

  /// 加入购物车
  void addGoodsToCart(Goods goods) async {
    Goods _goods;

    if (await provider.isExist(goods.goodsId)) {
      _goods = await provider.getGoods(goods.goodsId);
      print(_goods.toString());
      addGoodsAmount(_goods);
    } else {
      _goods = Goods(
        number: 1,
        isChecked: 0,
        goodsId: goods.goodsId,
        oriPrice: goods.oriPrice,
        presentPrice: goods.presentPrice,
        shopId: goods.shopId,
        goodsName: goods.goodsName,
        comPic: goods.comPic,
      );

      await provider.insertOrReplaceToDB(_goods);
    }

    refreshCartProducts();
  }

  void refresh() {
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
