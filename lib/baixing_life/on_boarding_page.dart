import 'package:flutter/material.dart';
import 'package:flutter_app/page_index.dart';
import 'package:flutter_app/store/index.dart';

import 'baixing_page.dart';

class OnBoardingPage extends StatefulWidget {
  OnBoardingPage({Key key}) : super(key: key);

  @override
  createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage>
    with TickerProviderStateMixin {
  PageController _controller;
  int currentPage = 0;
  bool lastPage = false;
  AnimationController animationController;
  Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      /// 预先缓存图片，避免直接使用时因为首次加载造成闪动
      pageList.forEach((image) {
        precacheImage(NetworkImage(image.imageUrl), context);
      });
    });

    _controller = PageController(
      initialPage: currentPage,
    );
    animationController =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    _scaleAnimation = Tween(begin: 0.6, end: 1.0).animate(animationController);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xFF485563), Color(0xFF29323C)],
                tileMode: TileMode.clamp,
                begin: Alignment.topCenter,
                stops: [0.0, 1.0],
                end: Alignment.bottomCenter)),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(fit: StackFit.expand, children: <Widget>[
              PageView.builder(
                  itemBuilder: (_, index) {
                    return AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          var page = pageList[index];
                          var delta;
                          var y = 1.0;

                          if (_controller.position.haveDimensions) {
                            delta = _controller.page - index;
                            y = 1 - delta.abs().clamp(0.0, 1.0);
                          }
                          return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Center(
                                    child: ImageLoadView(page.imageUrl,
                                        height: 200, fit: BoxFit.fitHeight)),
                                Container(
                                    margin: EdgeInsets.only(left: 12.0),
                                    height: 100.0,
                                    child: Stack(children: <Widget>[
                                      Opacity(
                                          opacity: .10,
                                          child: GradientText(page.title,
                                              gradient: LinearGradient(
                                                  colors: pageList[index]
                                                      .titleGradient),
                                              style: TextStyle(
                                                  fontSize: 100.0,
                                                  letterSpacing: 1.0))),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: 30.0, left: 22.0),
                                          child: GradientText(page.title,
                                              gradient: LinearGradient(
                                                  colors: pageList[index]
                                                      .titleGradient),
                                              style: TextStyle(fontSize: 70.0)))
                                    ])),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 34.0, top: 12.0),
                                    child: Transform(
                                        transform: Matrix4.translationValues(
                                            0, 50.0 * (1 - y), 0),
                                        child: Text(page.body,
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                color: Color(0xFF9B9B9B)))))
                              ]);
                        });
                  },
                  itemCount: pageList.length,
                  controller: _controller,
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                      if (currentPage == pageList.length - 1) {
                        lastPage = true;
                        animationController.forward();
                      } else {
                        lastPage = false;
                        animationController.reset();
                      }
                      debugPrint('$lastPage');
                    });
                  }),
              Positioned(
                  left: 30.0,
                  bottom: 55.0,
                  child: RectIndicator(
                      position: currentPage, count: pageList.length)),
              Positioned(
                  right: 30.0,
                  bottom: 30.0,
                  child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: Visibility(
                          visible: lastPage,
                          child: FloatingActionButton(
                              backgroundColor: Colors.white,
                              child: Icon(Icons.arrow_forward,
                                  color: Colors.black),
                              onPressed: () {
                                Store.value<BaixingModel>(context,
                                    listen: false)
                                  ..setPageIndex(0)
                                  ..setCategories(0, 0);
                                pushReplacement(context, IndexPage());
                              }))))
            ])));
  }
}

var pageList = [
  PageModel(
      imageUrl:
          "https://raw.githubusercontent.com/devefy/Flutter-Onboarding/master/assets/illustration.png",
      title: "MUSIC",
      body: "EXPERIENCE WICKED PLAYLISTS",
      titleGradient: gradients[0]),
  PageModel(
      imageUrl:
          "https://raw.githubusercontent.com/devefy/Flutter-Onboarding/master/assets/illustration2.png",
      title: "SPA",
      body: "FEEL THE MAGIC OF WELLNESS",
      titleGradient: gradients[1]),
  PageModel(
      imageUrl:
          "https://raw.githubusercontent.com/devefy/Flutter-Onboarding/master/assets/illustration3.png",
      title: "TRAVEL",
      body: "LET'S HIKE UP",
      titleGradient: gradients[2]),
];

List<List<Color>> gradients = [
  [Color(0xFF9708CC), Color(0xFF43CBFF)],
  [Color(0xFFE2859F), Color(0xFFFCCF31)],
  [Color(0xFF5EFCE8), Color(0xFF736EFE)],
];

class PageModel {
  var imageUrl;
  var title;
  var body;
  List<Color> titleGradient = [];

  PageModel({this.imageUrl, this.title, this.body, this.titleGradient});
}
