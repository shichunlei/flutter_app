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

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      vsync: this,
      length: 3,
    );

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation = Tween(begin: 0.0, end: 0.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  updatePicHeight(changed) {
    if (prevDy == 0) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerMove: (value) {
        updatePicHeight(value.position.dy);
      },
      onPointerUp: (value) {
        print(value.position);
        runAnimation();
        _controller.forward(from: 0);
      },
      child: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.black,
            expandedHeight: 416 + extraPicHeight,
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Divider(
                          color: Colors.grey[500],
                        ),
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
                color: index % 2 == 1 ? Colors.red : Colors.yellow,
                height: 40,
                child: Text('item$index'),
              ),
              childCount: 50,
            ),
          )
        ],
      ),
    );
  }
}
