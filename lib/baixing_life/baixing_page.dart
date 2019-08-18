import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app/custom_widgets/bubble_bottom_bar.dart';
import 'package:flutter_app/global/custom_icon.dart';

import 'index.dart';

class IndexPage extends StatefulWidget {
  final int index;
  final int subCategory;
  final int category;

  IndexPage({
    Key key,
    this.index = 0,
    this.category = 0,
    this.subCategory = 0,
  })  : assert(index != null),
        assert(category != null),
        assert(subCategory != null),
        super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage>
    with SingleTickerProviderStateMixin {
  int currentIndex;

  List<Widget> list = [];

  GoodsProvider provider;

  @override
  void initState() {
    super.initState();

    provider = GoodsProvider();

    currentIndex = widget.index;

    list
      ..add(HomePage('百姓生活+', provider))
      ..add(ClassifyPage('分类',
          categoryIndex: widget.category,
          subIndex: widget.subCategory,
          provider: provider))
      ..add(ShoppingCartPage('购物车', provider))
      ..add(MemberPage('会员'));
  }

  @override
  void dispose() {
    super.dispose();
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list[currentIndex],
      bottomNavigationBar: BubbleBottomBar(
        opacity: 0.2,
        currentIndex: currentIndex,
        onTap: changePage,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 8,
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor: Colors.red,
              icon: Icon(
                Icons.home,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.home,
                color: Colors.red,
              ),
              title: Text("首页")),
          BubbleBottomBarItem(
              backgroundColor: Colors.deepPurple,
              icon: Icon(
                Icons.dashboard,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.dashboard,
                color: Colors.deepPurple,
              ),
              title: Text("分类")),
          BubbleBottomBarItem(
              backgroundColor: Colors.indigo,
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.shopping_cart,
                color: Colors.indigo,
              ),
              title: Text("购物车")),
          BubbleBottomBarItem(
              backgroundColor: Colors.green,
              icon: Icon(
                CustomIcon.account_full,
                color: Colors.black,
              ),
              activeIcon: Icon(
                CustomIcon.account_full,
                color: Colors.green,
              ),
              title: Text("会员"))
        ],
      ),
    );
  }
}
