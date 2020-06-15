import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('关于商城')),
        body: SingleChildScrollView(
            child: Container(
                child: Image.network(
                    'http://images.baixingliangfan.cn/aboutUs2.jpg',
                    fit: BoxFit.fitWidth))));
  }
}
