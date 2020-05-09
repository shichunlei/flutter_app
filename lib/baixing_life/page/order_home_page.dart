import 'package:flutter/material.dart';
import 'package:flutter_app/baixing_life/page/order_view.dart';

class OrderHomePage extends StatefulWidget {
  final int index;

  const OrderHomePage({Key key, this.index = 0})
      : assert(index != null),
        super(key: key);

  @override
  createState() => _OrderHomePageState();
}

class _OrderHomePageState extends State<OrderHomePage>
    with SingleTickerProviderStateMixin {
  int currentIndex;

  TabController controller;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.index;

    controller = TabController(
        length: ordersState.length, vsync: this, initialIndex: currentIndex)
      ..addListener(() {});
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text('我的订单'),
            bottom: TabBar(
                tabs: ordersState.map((m) => Tab(text: m.title)).toList(),
                controller: controller,
                isScrollable: true,
                indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(style: BorderStyle.none)))),
        body: TabBarView(
            children:
                ordersState.map((m) => OrderPage(state: m.state)).toList(),
            controller: controller));
  }
}

class OrderTitle {
  int state;
  String title;

  OrderTitle({this.state, this.title});
}

final List<OrderTitle> ordersState = [
  OrderTitle(state: -1, title: '全部'),
  OrderTitle(state: 1, title: '待付款'),
  OrderTitle(state: 2, title: '待发货'),
  OrderTitle(state: 3, title: '待收货'),
  OrderTitle(state: 4, title: '待评价'),
  OrderTitle(state: 401, title: '已完成')
];
