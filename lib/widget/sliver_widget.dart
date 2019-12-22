import 'package:flutter/material.dart';

import 'package:flutter_app/delegates/custom_sliver_appbar_delegate.dart';
import 'package:flutter_app/page_index.dart';

enum AppBarBehavior { normal, pinned, floating, snapping }

class SliverWidget extends StatefulWidget {
  SliverWidget({Key key}) : super(key: key);

  @override
  createState() => _SliverWidgetState();
}

class _SliverWidgetState extends State<SliverWidget> {
  AppBarBehavior _appBarBehavior;

  @override
  void initState() {
    super.initState();

    _appBarBehavior = AppBarBehavior.pinned;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _buildSliverAppBar(),
          _buildSliverToBoxAdapter(),
          _buildSliverPersistentHeader(),
          _buildSliverList(context),
          _buildSliverPersistentHeader(),
          _buildSliverList2(context),
          _buildSliverPersistentHeader(),
          _buildSliverGrid(context),
          _buildSliverPersistentHeader(),
          _buildSliverFixedExtentList(context),
          _buildSliverPersistentHeader(),
          _buildSliverFillViewport(),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    /// SliverAppBar 是一个可伸缩的头部，可以实现上拉收起，下拉展开效果
    return SliverAppBar(
      /// 背景色
      backgroundColor: Colors.white,

      /// 展开高度
      expandedHeight: 200.0,

      /// 是否预留高度
      primary: true,

      /// 是否固定在顶部
      pinned: _appBarBehavior == AppBarBehavior.pinned,

      /// 是否随着滑动隐藏标题
      floating: _appBarBehavior == AppBarBehavior.floating ||
          _appBarBehavior == AppBarBehavior.snapping,

      /// 与floating结合使用
      snap: _appBarBehavior == AppBarBehavior.snapping,

      actions: <Widget>[
        PopupMenuButton<AppBarBehavior>(
          onSelected: (AppBarBehavior value) {
            setState(() {
              _appBarBehavior = value;
            });
          },
          itemBuilder: (BuildContext context) =>
              <PopupMenuItem<AppBarBehavior>>[
            PopupMenuItem<AppBarBehavior>(
                value: AppBarBehavior.normal,
                child: Text(
                  'App bar scrolls away',
                  style: TextStyle(
                      color: _appBarBehavior == AppBarBehavior.normal
                          ? Colors.red
                          : Colors.black54),
                )),
            PopupMenuItem<AppBarBehavior>(
                value: AppBarBehavior.pinned,
                child: Text('App bar stays put',
                    style: TextStyle(
                        color: _appBarBehavior == AppBarBehavior.pinned
                            ? Colors.red
                            : Colors.black54))),
            PopupMenuItem<AppBarBehavior>(
                value: AppBarBehavior.floating,
                child: Text('App bar floats',
                    style: TextStyle(
                        color: _appBarBehavior == AppBarBehavior.floating
                            ? Colors.red
                            : Colors.black54))),
            PopupMenuItem<AppBarBehavior>(
                value: AppBarBehavior.snapping,
                child: Text('App bar snaps',
                    style: TextStyle(
                        color: _appBarBehavior == AppBarBehavior.snapping
                            ? Colors.red
                            : Colors.black54))),
          ],
        ),
      ],

      /// 标题是否居中
      centerTitle: true,

      /// 可以展开区域，通常是一个FlexibleSpaceBar
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        title: Text(
          'Sliver Widget',
          style: TextStyle(color: Colors.grey),
        ),
        background: ImageLoadView(
          'https://www.snapphotography.co.nz/wp-content/uploads/New-Zealand-Landscape-Photography-prints-12.jpg',
        ),
      ),

      /// 阴影
      elevation: 2.0,

      /// 主题明亮
      brightness: Brightness.light,

      /// icon的主题样式,默认的颜色是黑色的，不透明为1，size是24
      iconTheme: IconThemeData(color: Colors.black, opacity: 0.8, size: 30),

      /// 字体样式
      textTheme: TextTheme(),
    );
  }

  Widget _buildSliverToBoxAdapter() {
    /// SliverToBoxAdapter的child属性可以加载普通widget组件
    return SliverToBoxAdapter(
      child: Container(
        alignment: Alignment.center,
        child: Text(
          'SliverToBoxAdapter',
          style: TextStyle(color: Colors.white, fontSize: 24.0),
        ),
        height: 100.0,
        color: Colors.pinkAccent.withOpacity(0.8),
      ),
    );
  }

  Widget _buildSliverPersistentHeader() {
    /// SliverPersistentHeader有点类似SliverAppBar，同样可以收起和展开，可以放置到slivers任何一个位置
    return SliverPersistentHeader(
      delegate: CustomSliverAppBarDelegate(
          minHeight: 60.0,
          maxHeight: 180.0,
          child: Container(
            child: ImageLoadView(
              'https://www.snapphotography.co.nz/wp-content/uploads/New-Zealand-Landscape-Photography-prints-12.jpg',
            ),
          )),
      pinned: false,
      floating: false,
    );
  }

  Widget _buildSliverList(BuildContext context) {
    /// SliverList类似ListView，他有两种表现形式：SliverChildBuilderDelegate和SliverChildListDelegate，两者区别在于SliverChildBuilderDelegate可以加载不确定数量的列表，而SliverChildListDelegate只能加载固定已知数量。
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Container(
            height: 40.0,
            child: Text('Sliver List Item $index'),
            alignment: Alignment.center,
            color: Colors.red[100 * (index % 10)],
          );
        },
        childCount: 10,
      ),
    );
  }

  Widget _buildSliverList2(BuildContext context) {
    /// SliverList类似ListView，他有两种表现形式：SliverChildBuilderDelegate和SliverChildListDelegate，两者区别在于SliverChildBuilderDelegate可以加载不确定数量的列表，而SliverChildListDelegate只能加载固定已知数量。
    return SliverList(
      delegate: SliverChildListDelegate([
        Container(
          height: 40.0,
          child: Text('Sliver List Item 0'),
          alignment: Alignment.center,
          color: Colors.red[100 * (0 % 10)],
        ),
        Container(
          height: 40.0,
          child: Text('Sliver List Item 1'),
          alignment: Alignment.center,
          color: Colors.red[100 * (1 % 10)],
        ),
        Container(
          height: 40.0,
          child: Text('Sliver List Item 2'),
          alignment: Alignment.center,
          color: Colors.red[100 * (2 % 10)],
        ),
        Container(
          height: 40.0,
          child: Text('Sliver List Item 3'),
          alignment: Alignment.center,
          color: Colors.red[100 * (3 % 10)],
        ),
        Container(
          height: 40.0,
          child: Text('Sliver List Item 4'),
          alignment: Alignment.center,
          color: Colors.red[100 * (4 % 10)],
        )
      ]),
    );
  }

  Widget _buildSliverGrid(BuildContext context) {
    /// SliverGrid 可以设置固定一行显示几个SliverGridDelegateWithFixedCrossAxisCount，也可以SliverGridDelegateWithMaxCrossAxisExtent设置子元素最大宽度，让flutter决定一行几个。count和extent就是封装方法。
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(
            child: Text('Sliver Grid Item $index'),
            alignment: Alignment.center,
            color: Colors.teal[100 * (index % 10)],
          );
        },
        childCount: 10,
      ),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200.0,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 4.0,
      ),
    );
  }

  Widget _buildSliverFixedExtentList(BuildContext context) {
    /// SliverFixedExtentList与SliverList类似，唯一区别是SliverFixedExtentList可以设置固定高度。
    return SliverFixedExtentList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Container(
            alignment: Alignment.center,
            color: Colors.lightBlue[100 * (index % 10)],
            child: Text('Sliver Fixed Extent List Item $index'),
          );
        },
        childCount: 10,
      ),
      itemExtent: 50.0,
    );
  }

  Widget _buildSliverFillViewport() {
    return SliverFillViewport(
      delegate: SliverChildListDelegate(
        <Widget>[
          Container(
            height: 100.0,
            color: Colors.pinkAccent.withOpacity(0.8),
            child: Center(
              child: Text(
                'SliverFillViewport',
                style: TextStyle(color: Colors.white, fontSize: 24.0),
              ),
            ),
          ),
        ],
      ),
      viewportFraction: 1.0,
    );
  }
}
