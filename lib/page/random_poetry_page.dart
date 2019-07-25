import 'package:flutter/material.dart';

class RandomPoetryPage extends StatefulWidget {
  @override
  createState() => _RandomPoetryPageState();
}

class _RandomPoetryPageState extends State<RandomPoetryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('随机诗词'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh), onPressed: () {}, tooltip: "刷新"),
        ],
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: Text('该板块因有人恶意刷接口，导致接口调用频繁，接口已经不能稳定运行，所以下线'),
      ),
    );
  }
}
