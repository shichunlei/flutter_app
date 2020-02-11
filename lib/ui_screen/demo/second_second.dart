import 'package:flutter/material.dart';

class SecondSecondPage extends StatefulWidget {
  SecondSecondPage({Key key}) : super(key: key);

  @override
  createState() => _SecondSecondPageState();
}

class _SecondSecondPageState extends State<SecondSecondPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Container(
        child: Center(child: Text('这里是当日未完成页面的内容')),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
