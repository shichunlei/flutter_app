import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/delegates/search_bar_delegate.dart';

import '../page_index.dart';

import 'index.dart';

class SettingMenuPage extends StatefulWidget {
  SettingMenuPage({Key key}) : super(key: key);

  @override
  createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingMenuPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation topAnimation;
  Animation bottomAnimation;

  double width;

  int _currentIndex = 0;

  List<Widget> list = [];

  @override
  void initState() {
    super.initState();

    width = Utils.width;

    list..add(_buildColumnView())..add(_buildGridView());

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    topAnimation = Tween(begin: -300.0, end: 0.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    bottomAnimation = Tween(begin: 600, end: 0.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward(); //放在这里开启动画 ，打开页面就播放动画
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget child) {
          return Scaffold(
              backgroundColor: Colors.grey[200],
              body: Stack(alignment: Alignment.bottomLeft, children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(children: <Widget>[
                    /// 上面部分
                    Transform(
                      transform: Matrix4.translationValues(
                          0, topAnimation.value.toDouble(), 0),
                      child: Column(children: <Widget>[
                        /// 搜索栏
                        _buildSearchView(),

                        Gaps.vGap20,

                        /// 设置选项
                        _buildRowView()
                      ]),
                    ),
                    SizedBox(height: 40),

                    /// 下面部分
                    Transform(
                        transform: Matrix4.translationValues(
                            0, bottomAnimation.value.toDouble(), 0),
                        child: list[_currentIndex])
                  ]),
                ),
                _buildBackButton()
              ]));
        });
  }

  Widget _buildBackButton() {
    return Padding(
        padding: EdgeInsets.only(left: 10, bottom: 10),
        child: FloatingActionButton(
            backgroundColor: Colors.black,
            mini: true,
            onPressed: () {
              if (_currentIndex == 0) {
                _controller.reverse();
                Navigator.of(context).pop();
              } else {
                setState(() => _currentIndex = 0);
              }
            },
            child: Icon(
                _currentIndex == 0 ? Icons.close : Icons.keyboard_arrow_left,
                color: Colors.white)));
  }

  Widget _buildSearchView() {
    return Container(
        margin: EdgeInsets.only(top: Utils.topSafeHeight),
        child: InkWell(
            child: Row(children: <Widget>[
              Icon(FeatherIcons.search),
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
              text: '设置', icon: Icon(FeatherIcons.settings), onPressed: () {})),
      Expanded(
          child: IconText(
              text: '主题', icon: Icon(FeatherIcons.sun), onPressed: () {})),
      Expanded(
          child: IconText(
              text: '离线',
              icon: Icon(FeatherIcons.downloadCloud),
              onPressed: () {})),
      Expanded(
          child: IconText(
              text: '推荐', icon: Icon(FeatherIcons.gift), onPressed: () {}))
    ]);
  }

  Widget _buildColumnView() {
    return Column(children: <Widget>[
      ListTile(
          leading: Image.asset('images/qdaily/icon_menu_about_day.png',
              height: 35, width: 35),
          title: Text('关于我们'),
          onTap: () {}),
      ListTile(
          leading: Image.asset('images/qdaily/icon_menu_category_day.png',
              height: 35, width: 35),
          title: Row(children: <Widget>[
            Text('新闻分类'),
            Icon(Icons.keyboard_arrow_right)
          ]),
          onTap: () => setState(() => _currentIndex = 1)),
      ListTile(
          leading: Image.asset('images/qdaily/icon_menu_column_day.png',
              height: 35, width: 35),
          title: Text('栏目中心'),
          onTap: () => pushNewPage(context, ColumnsPage())),
      ListTile(
          leading: Image.asset('images/qdaily/icon_menu_notification_day.png',
              height: 35, width: 35),
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
    ]);
  }

  Widget _buildGridView() {
    List<CategoryBean> category = CategoryBean.getCategory();
    return GridView.builder(
        shrinkWrap: true,
        primary: false,
        padding: EdgeInsets.only(top: 0),
        itemCount: category.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: (width - 40) / 2 / 55),
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
              leading: ClipRRect(
                  borderRadius: BorderRadius.circular(17.5),
                  child: Image.network(category[index].imageLab,
                      height: 35, width: 35)),
              title: Text('${category[index].title}'),
              onTap: () => pushNewPage(
                  context,
                  TagsPage(
                      title: category[index].title,
                      id: category[index].id,
                      type: category[index].type)));
        });
  }
}
