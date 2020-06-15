import 'package:custom_widgets/bubble_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app/global/custom_icon.dart';
import 'package:flutter_app/store/index.dart';

import 'index.dart';

class IndexPage extends StatefulWidget {
  @override
  createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage>
    with SingleTickerProviderStateMixin {
  List<Widget> list = [];

  @override
  void initState() {
    super.initState();

    list
      ..add(HomePage('百姓生活+'))
      ..add(ClassifyPage('分类'))
      ..add(ShoppingCartPage('购物车'))
      ..add(MemberPage('会员'));
  }

  @override
  Widget build(BuildContext context) {
    var store = Store.value<BaixingModel>(context);

    return Scaffold(
        body: list[store.currentPage],
        bottomNavigationBar: BubbleBottomBar(
            opacity: 0.2,
            currentIndex: store.currentPage,
            onTap: (int index) {
              store.setPageIndex(index);
              setState(() {});
            },
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            elevation: 8,
            items: <BubbleBottomBarItem>[
              BubbleBottomBarItem(
                  backgroundColor: Colors.red,
                  icon: Icon(Icons.home, color: Colors.black),
                  activeIcon: Icon(Icons.home, color: Colors.red),
                  title: Text("首页")),
              BubbleBottomBarItem(
                  backgroundColor: Colors.deepPurple,
                  icon: Icon(Icons.dashboard, color: Colors.black),
                  activeIcon: Icon(Icons.dashboard, color: Colors.deepPurple),
                  title: Text("分类")),
              BubbleBottomBarItem(
                  backgroundColor: Colors.indigo,
                  icon: Icon(Icons.shopping_cart, color: Colors.black),
                  activeIcon: Icon(Icons.shopping_cart, color: Colors.indigo),
                  title: Text("购物车")),
              BubbleBottomBarItem(
                  backgroundColor: Colors.green,
                  icon: Icon(CustomIcon.account_full, color: Colors.black),
                  activeIcon:
                      Icon(CustomIcon.account_full, color: Colors.green),
                  title: Text("会员"))
            ]));
  }
}
