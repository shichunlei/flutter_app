import 'package:flutter/material.dart';
import 'package:flutter_app/ui/toolbar.dart';
import 'package:flutter_app/utils/loading_util.dart';
import 'package:flutter_app/utils/utils.dart';

class MemberPage extends StatefulWidget {
  final String title;
  MemberPage(this.title,{Key key}) : super(key: key);

  @override
  _MemberPageState createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage>
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
            backgroundColor: Colors.green,
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
