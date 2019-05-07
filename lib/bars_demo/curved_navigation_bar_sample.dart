import 'package:flutter/material.dart';
import 'package:flutter_app/bars_demo/each_view.dart';
import 'package:flutter_app/custom_widgets/curved_navigation_bar.dart';

class CurvedNavigationBarSample extends StatefulWidget {
  CurvedNavigationBarSample({Key key}) : super(key: key);

  @override
  createState() => _CurvedNavigationBarSampleState();
}

class _CurvedNavigationBarSampleState extends State<CurvedNavigationBarSample>
    with SingleTickerProviderStateMixin {
  int _page = 0;

  var _controller = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
            controller: _controller,
            children: <Widget>[
              EachView('add'),
              EachView('list'),
              EachView('compare_arrows'),
              EachView('call_split'),
              EachView('perm_identity')
            ],
            physics: NeverScrollableScrollPhysics()),
        bottomNavigationBar: CurvedNavigationBar(
            items: <Widget>[
              Icon(Icons.add, size: 30),
              Icon(Icons.list, size: 30),
              Icon(Icons.compare_arrows, size: 30),
              Icon(Icons.call_split, size: 30),
              Icon(Icons.perm_identity, size: 30)
            ],
            color: Colors.white,
            buttonBackgroundColor: Colors.white,
            backgroundColor: Colors.blueAccent,
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 600),
            onTap: (index) {
              setState(() {
                _page = index;
              });
            }));
  }
}
