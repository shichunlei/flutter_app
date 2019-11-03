import 'package:flutter/material.dart';

import '../page_index.dart';
import 'index.dart';

class QDailyIndexPage extends StatefulWidget {
  QDailyIndexPage({Key key}) : super(key: key);

  @override
  createState() => _QDailyIndexPageState();
}

class _QDailyIndexPageState extends State<QDailyIndexPage> {
  List<Tab> titleTabs = [Tab(text: 'NEWS'), Tab(text: 'LABS')];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: titleTabs.length,
        child: Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0.0,
              title: TabBar(
                  tabs: titleTabs,
                  labelStyle: TextStyle(fontSize: 18.0),
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 1.0,
                  indicatorColor: qdailyMajorColor)),
          body: Stack(alignment: Alignment.bottomLeft, children: <Widget>[
            TabBarView(children: <Widget>[QHomePage(), LabsPage()]),
            Padding(
                padding: EdgeInsets.only(left: 10, bottom: 10),
                child: FloatingActionButton(
                  heroTag: "qdaily",
                  backgroundColor: Colors.black,
                  mini: true,
                  onPressed: () => pushNewPage(context, SettingMenuPage()),
                  child: Icon(CustomIcon.qdaily_logo,
                      color: qdailyMajorColor, size: 28),
                ))
          ]),
        ));
  }
}
