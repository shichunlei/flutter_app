import 'package:flutter/material.dart';
import 'package:flutter_app/ui/toolbar.dart';
import 'package:flutter_app/utils/loading_util.dart';
import 'package:flutter_app/utils/utils.dart';

class ClassifyPage extends StatefulWidget {
  final String title;

  ClassifyPage(this.title, {Key key}) : super(key: key);

  @override
  _ClassifyPageState createState() => _ClassifyPageState();
}

class _ClassifyPageState extends State<ClassifyPage>
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
            backgroundColor: Colors.deepPurple,
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
