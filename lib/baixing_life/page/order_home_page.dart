import 'package:flutter/material.dart';

class OrderHomePage extends StatefulWidget {
  final int index;

  OrderHomePage({Key key, this.index = 0})
      : assert(index != null),
        super(key: key);

  @override
  _OrderHomePageState createState() => _OrderHomePageState();
}

class _OrderHomePageState extends State<OrderHomePage> {
  int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.index;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('我的订单'),
      ),
      body: null,
    );
  }
}
