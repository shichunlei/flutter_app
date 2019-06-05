import 'package:flutter/material.dart';
import 'package:flutter_app/qdaily/lab/labs.dart';

import '../page_index.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key key}) : super(key: key);

  @override
  createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  List<Tab> titleTabs = [Tab(text: 'NEWS'), Tab(text: 'LABS')];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: titleTabs.length,
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0.0,
              title: TabBar(
                  tabs: titleTabs,
                  labelStyle: TextStyle(fontSize: 18.0),
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 1.0,
                  indicatorColor: Color(0xFFFFD003))),
          body: Stack(alignment: Alignment.bottomLeft, children: <Widget>[
            TabBarView(children: <Widget>[HomePage(), LabsPage()]),
            Padding(
                padding: EdgeInsets.only(left: 10, bottom: 10),
                child: FloatingActionButton(
                    backgroundColor: Colors.black,
                    mini: true,
                    onPressed: () => pushNewPage(context, SettingPage()),
                    child: Icon(CustomIcon.qdaily_logo,
                        color: Color(0xFFFFD003), size: 28)))
          ]),
        ));
  }
}
