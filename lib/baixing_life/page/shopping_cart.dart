import 'package:flutter/material.dart';
import 'package:flutter_app/ui/toolbar.dart';
import 'package:flutter_app/utils/loading_util.dart';
import 'package:flutter_app/utils/utils.dart';

class ShoppingCartPage extends StatefulWidget {
  final String title;

  ShoppingCartPage(this.title, {Key key}) : super(key: key);

  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

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
    return Scaffold(
      body: Column(
        children: <Widget>[
          ToolBar(
            title: '${widget.title}',
            backgroundColor: Colors.indigo,
          ),
          Container(
            child: getLoadingWidget(),
            height: Utils.height - Utils.navigationBarHeight - 48 - 16,
          ),
        ],
      ),
    );
  }
}
