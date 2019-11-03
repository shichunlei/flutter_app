import 'package:flutter_app/delegates/search_bar_delegate.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter/material.dart';

import '../page_index.dart';

import 'index.dart';

class SettingMenuPage extends StatefulWidget {
  SettingMenuPage({Key key}) : super(key: key);

  @override
  createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingMenuPage>
    with TickerProviderStateMixin {
  AnimationController _tbController;
  Animation _tbAnimation;

  AnimationController _lrController;
  Animation _lrAnimation;

  int bottomPage = 0;

  @override
  void initState() {
    super.initState();

    _tbController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    _tbAnimation =
        CurvedAnimation(parent: _tbController, curve: Curves.easeInOut);

    _tbController.forward(); //放在这里开启动画 ，打开页面就播放动画

    _lrController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    _lrAnimation = CurvedAnimation(parent: _lrController, curve: Curves.linear);

    _lrController.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        bottomPage = 1;
      } else if (status == AnimationStatus.reverse) {
        bottomPage = 0;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tbController?.dispose();
    _lrController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: Stack(children: <Widget>[
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(children: <Widget>[
                /// 上面部分
                SlideTransition(
                  child: Column(children: <Widget>[
                    Gaps.vGap20,

                    /// 搜索栏
                    _buildSearchView(),

                    Gaps.vGap20,

                    /// 设置选项
                    _buildRowView()
                  ], mainAxisSize: MainAxisSize.min),
                  position:
                      Tween<Offset>(begin: Offset(0.0, -1.0), end: Offset.zero)
                          .animate(_tbAnimation),
                ),
                SizedBox(height: 40),

                /// 下面部分
                SlideTransition(
                    child: Stack(children: <Widget>[
                      _buildColumnView(),
                      _buildGridView()
                    ]),
                    position:
                        Tween<Offset>(begin: Offset(0, 1), end: Offset.zero)
                            .animate(_tbAnimation))
              ])),
          Positioned(child: _buildBackButton(), left: 0.0, bottom: 0.0)
        ]));
  }

  Widget _buildBackButton() {
    return Padding(
        padding: EdgeInsets.only(left: 10, bottom: 10),
        child: FloatingActionButton(
          heroTag: "qdaily",
          backgroundColor: Colors.black,
          mini: true,
          onPressed: () {
            if (_lrController.status == AnimationStatus.dismissed) {
              _tbController.reverse();
              Navigator.of(context).pop();
            } else {
              _lrController.reverse();
            }
          },
          child: AnimatedSwitcher(
              transitionBuilder: (Widget child, Animation<double> animation) =>
                  ScaleTransition(child: child, scale: animation),
              duration: Duration(milliseconds: 500),
              child: Icon(
                  bottomPage == 0 ? Icons.close : Icons.keyboard_arrow_left,
                  color: Colors.white,
                  key: ValueKey<int>(bottomPage))),
        ));
  }

  Widget _buildSearchView() {
    return Container(
        margin: EdgeInsets.only(top: Utils.topSafeHeight),
        child: InkWell(
            child: Row(children: <Widget>[
              Icon(Feather.search),
              SizedBox(width: 10),
              Text('搜索')
            ]),
            onTap: () =>
                showSearch(context: context, delegate: SearchBarDelegate())),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))));
  }

  Widget _buildRowView() {
    return Row(children: <Widget>[
      Expanded(
          child: IconText(
              text: '设置', icon: Icon(Feather.settings), onPressed: () {})),
      Expanded(
          child:
              IconText(text: '主题', icon: Icon(Feather.sun), onPressed: () {})),
      Expanded(
          child: IconText(
              text: '离线',
              icon: Icon(Feather.download_cloud),
              onPressed: () {})),
      Expanded(
          child:
              IconText(text: '推荐', icon: Icon(Feather.gift), onPressed: () {}))
    ]);
  }

  /// 左侧部分
  Widget _buildColumnView() {
    return SlideTransition(
        child: Column(children: <Widget>[
          ListTile(
              leading: Image.asset('images/qdaily/icon_menu_about_day.png',
                  height: 35, width: 35),
              title: Text('关于我们'),
              onTap: () => pushNewPage(
                  context,
                  WebViewPage(
                      url: 'http://m.qdaily.com/mobile/aboutus.html',
                      title: '关于我们'))),
          ListTile(
              leading: Image.asset('images/qdaily/icon_menu_category_day.png',
                  height: 35, width: 35),
              title: Row(children: <Widget>[
                Text('新闻分类'),
                Icon(Icons.keyboard_arrow_right)
              ]),
              onTap: () => _lrController.forward()),
          ListTile(
              leading: Image.asset('images/qdaily/icon_menu_column_day.png',
                  height: 35, width: 35),
              title: Text('栏目中心'),
              onTap: () => pushNewPage(context, ColumnsPage())),
          ListTile(
              leading: Image.asset(
                  'images/qdaily/icon_menu_notification_day.png',
                  height: 35,
                  width: 35),
              title: Text('我的消息'),
              onTap: () {}),
          ListTile(
              leading: Image.asset('images/qdaily/icon_menu_usercenter_day.png',
                  height: 35, width: 35),
              title: Text('个人中心'),
              onTap: () {}),
          ListTile(
              leading: Image.asset('images/qdaily/icon_menu_feedback_day.png',
                  height: 35, width: 35),
              title: Text('意见反馈'),
              onTap: () {})
        ]),
        position: Tween<Offset>(begin: Offset.zero, end: Offset(-1.0, 0.0))
            .animate(_lrAnimation));
  }

  /// 右侧部分
  Widget _buildGridView() {
    List<CategoryBean> category = CategoryBean.getCategory();
    return SlideTransition(
        child: GridView.builder(
            shrinkWrap: true,
            primary: false,
            padding: EdgeInsets.only(top: 0),
            itemCount: category.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: (Utils.width - 40) / 2 / 55),
            itemBuilder: (BuildContext context, int index) => ListTile(
                leading: ClipRRect(
                    borderRadius: BorderRadius.circular(17.5),
                    child: Image.network(category[index].imageLab,
                        height: 35, width: 35)),
                title: Text('${category[index].title}'),
                onTap: () => pushNewPage(
                    context,
                    TagsPage(
                        title: category[index].title,
                        id: category[index].id)))),
        position: Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset.zero)
            .animate(_lrAnimation));
  }
}
