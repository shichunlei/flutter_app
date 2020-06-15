import 'package:flutter/material.dart';
import 'package:flutter_app/baixing_life/index.dart';
import 'package:flutter_app/page_index.dart';

class ShopInfoPage extends StatefulWidget {
  final String id;
  final String name;

  const ShopInfoPage({Key key, @required this.id,@required this.name}) : super(key: key);

  @override
  createState() => _ShopInfoPageState();
}

class _ShopInfoPageState extends State<ShopInfoPage> {
  ShopInfo shopInfo;

  @override
  void initState() {
    super.initState();

    getShopInfo(widget.id);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: Text('${widget.name}')),
      body: Column(
        children: [],
      ),
    );
  }

  void getShopInfo(String id) async {
    shopInfo = await ApiService.getBaixingShopInfo(id);

    setState(() {});
  }
}
