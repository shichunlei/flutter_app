import 'package:flutter/material.dart';

import 'package:flutter_app/delegates/custom_sliver_appbar_delegate.dart';

class SliverWidget extends StatefulWidget {
  SliverWidget({Key key}) : super(key: key);

  @override
  _SliverWidgetState createState() => _SliverWidgetState();
}

class _SliverWidgetState extends State<SliverWidget> {
  ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _controller,
        slivers: <Widget>[
          _buildSliverAppBar(),
          _buildSliverToBoxAdapter(),
          _buildSliverPersistentHeader(),
          _buildSliverList(context),
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
    return SliverAppBar(
      /// 背景色
      backgroundColor: Colors.white,

      /// 展开高度
      expandedHeight: 200.0,

      /// 是否随着滑动隐藏标题
      floating: false,

      /// 与floating结合使用
      snap: false,

      /// 是否固定在顶部
      pinned: false,

      /// 是否预留高度
      primary: true,

      /// 标题是否居中
      centerTitle: true,

      /// 可以展开区域，通常是一个FlexibleSpaceBar
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        title: Text('Sliver Widget'),
        background: Image.network(
          'https://www.snapphotography.co.nz/wp-content/uploads/New-Zealand-Landscape-Photography-prints-12.jpg',
          fit: BoxFit.cover,
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
    return SliverPersistentHeader(
      delegate: CustomSliverAppBarDelegate(
          minHeight: 60.0,
          maxHeight: 180.0,
          child: Container(
            child: Image.network(
              'https://www.snapphotography.co.nz/wp-content/uploads/New-Zealand-Landscape-Photography-prints-12.jpg',
              fit: BoxFit.cover,
            ),
          )),
      pinned: false,
      floating: false,
    );
  }

  Widget _buildSliverList(BuildContext context) {
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

  Widget _buildSliverGrid(BuildContext context) {
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
