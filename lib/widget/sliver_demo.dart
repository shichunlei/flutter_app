import 'package:flutter/material.dart';
import 'package:flutter_app/page_index.dart';

class SliverDemo extends StatefulWidget {
  SliverDemo({Key key}) : super(key: key);

  @override
  createState() => _SliverDemoState();
}

class _SliverDemoState extends State<SliverDemo> with TickerProviderStateMixin {
  double extraPicHeight = 0;
  BoxFit fit = BoxFit.fitWidth;
  double prevDy = 0.0;

  AnimationController _controller;
  Animation<double> _animation;

  TabController _tabController;

  double offset = 0.0;

  ScrollController _scrollController = ScrollController();

  Offset downPoint;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      vsync: this,
      length: 3,
    );

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    _scrollController.addListener(() {
      offset = _scrollController.offset;
      setState(() {
//        print('----------$offset');
      });
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    _scrollController?.dispose();
    _tabController?.dispose();
    super.dispose();
  }

  updatePicHeight(changed) {
    if (offset == 0.0) {
      if (prevDy == 0.0) {
        prevDy = changed;
      }

      extraPicHeight += changed - prevDy;

      if (extraPicHeight >= Utils.width * 375 / 500 - 200) {
        fit = BoxFit.fitHeight;
      } else {
        fit = BoxFit.fitWidth;
      }

      setState(() {
        prevDy = changed;
      });
    }
  }

  runAnimation() {
    setState(() {
      _animation = Tween(begin: extraPicHeight, end: 0.0).animate(_controller)
        ..addListener(() {
          if (extraPicHeight >= Utils.width * 375 / 500 - 200) {
            fit = BoxFit.fitHeight;
          } else {
            fit = BoxFit.fitWidth;
          }
          setState(() {
            extraPicHeight = _animation.value;
          });
        });
      prevDy = 0.0;
    });

    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerMove: (value) {
//        print('${value.position.dy}----------');
        updatePicHeight(value.position.dy);
      },
      onPointerUp: (value) {
        /// 按下的点跟抬起的点不是同一个点（即收滑动了位移）并且头部图片滑动到原始位置
        if (downPoint != value.position && offset == 0.0) {
          runAnimation();
        }
      },
      onPointerDown: (value) {
        setState(() {
          downPoint = value.position;
        });
      },
      child: Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          physics: ClampingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              backgroundColor: Colors.black,
              expandedHeight: 310 + extraPicHeight,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ImageLoadView(
                          'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2154519371,955032896&fm=26&gp=0.jpg',
                          fit: fit,
                          width: Utils.width,
                          height: 200 + extraPicHeight,
                        ),
                        Container(
                          height: 100,
                        ),
                      ],
                    ),
                    Positioned(
                      top: 180 + extraPicHeight,
                      left: 20,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        padding: EdgeInsets.all(2.0),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'http://p1.music.126.net/y_aPHj1dNMylbPxGLrJi5Q==/109951163835342783.jpg'),
                          radius: 50,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              bottom: PreferredSize(
                child: TabBar(
                  tabs: [Tab(text: '作品'), Tab(text: '动态'), Tab(text: '喜欢')],
                  controller: _tabController,
                ),
                preferredSize: Size.fromHeight(
                  Utils.navigationBarHeight - Utils.topSafeHeight,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, index) => Container(
                  padding: EdgeInsets.all(20),
                  color: index % 2 == 1 ? Colors.red : Colors.yellow,
                  child: Text(
                    'item$index',
                    style: TextStyles.textWhite16,
                  ),
                ),
                childCount: 50,
              ),
            )
          ],
        ),
      ),
    );
  }
}
