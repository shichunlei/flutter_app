import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/bean/movie.dart';
import 'package:flutter_app/page_index.dart';

List<Movie> movies = [
  Movie(
      url:
          'https://dss2.baidu.com/6ONYsjip0QIZ8tyhnq/it/u=2617297214,2858371489&fm=58&app=83&f=JPEG?w=300&h=400&s=6CC1A946BEC900DE112908B30300D090',
      title: '宇宙尽头'),
  Movie(
      url:
          'https://cdn.shopify.com/s/files/1/0057/3728/3618/products/5cae019e64c0ee10ead36a00e60f0137_eeb2d749-fdbe-46fd-978a-870cc7e0ddf7_500x.jpg?v=1573593942',
      title: 'Joker'),
  Movie(
      url:
          'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2581346773.webp',
      title: '大红包'),
  Movie(
      url:
          'https://dss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=3401745210,3434810146&fm=58&app=83&f=JPEG?w=400&h=533&s=E8E2A144FAB1AE5D0CFD548403007082',
      title: '小丑'),
];

class MoviesConceptPage extends StatefulWidget {
  @override
  createState() => _MoviesConceptPageState();
}

class _MoviesConceptPageState extends State<MoviesConceptPage> {
  final pageController = PageController(viewportFraction: .8);
  final ValueNotifier<double> _pageNotifier = ValueNotifier(0.0);

  void _listener() {
    _pageNotifier.value = pageController.page;
    setState(() {});
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      pageController.addListener(_listener);
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.removeListener(_listener);
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(20);

    return Scaffold(
      body: Stack(children: [
        Positioned.fill(
            child: ValueListenableBuilder<double>(
                valueListenable: _pageNotifier,
                builder: (context, value, child) {
                  return Stack(
                      children: movies.reversed
                          .toList()
                          .asMap()
                          .entries
                          .map((entry) => Positioned.fill(
                              child: ClipRect(
                                  clipper: MyClipper(
                                      percentage: value,
                                      title: entry.value.title,
                                      index: entry.key),
                                  child: ImageLoadView(entry.value.url))))
                          .toList());
                })),
        PageView.builder(
            itemCount: movies.length,
            controller: pageController,
            itemBuilder: (context, index) {
              final lerp =
                  lerpDouble(0, 1, (index - _pageNotifier.value).abs());

              double opacity =
                  lerpDouble(0.0, .5, (index - _pageNotifier.value).abs());
              if (opacity > 1.0) opacity = 1.0;
              if (opacity < 0.0) opacity = 0.0;
              return Transform.translate(
                  offset: Offset(0.0, lerp * 50),
                  child: Opacity(
                      opacity: (1 - opacity),
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Card(
                              color: Colors.white,
                              borderOnForeground: true,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                  borderRadius: borderRadius),
                              clipBehavior: Clip.hardEdge,
                              child: Container(
                                  height: Utils.height / 1.5,
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(children: [
                                    Expanded(
                                        child: ClipRRect(
                                            borderRadius: borderRadius,
                                            child: ImageLoadView(
                                                movies[index].url))),
                                    SizedBox(height: 15),
                                    Text(movies[index].title,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black,
                                            fontSize: 24)),
                                    RaisedButton(
                                        color: Colors.black,
                                        child: Text('BUY TICKET',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        onPressed: () {})
                                  ]))))));
            }),
        Positioned(
            top: 30,
            left: 10,
            child: DecoratedBox(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Colors.black38,
                      offset: Offset(5, 5),
                      blurRadius: 20,
                      spreadRadius: 5)
                ]),
                child: BackButton(color: Colors.white)))
      ]),
    );
  }
}

class MyClipper extends CustomClipper<Rect> {
  final double percentage;
  final String title;
  final int index;

  MyClipper({this.percentage = 0.0, this.title, this.index});

  @override
  Rect getClip(Size size) {
    int currentIndex = movies.length - 1 - index;
    final realPercent = (currentIndex - percentage).abs();
    if (currentIndex == percentage.truncate()) {
      return Rect.fromLTWH(
          0.0, 0.0, size.width * (1 - realPercent), size.height);
    }
    if (percentage.truncate() > currentIndex) {
      return Rect.fromLTWH(0.0, 0.0, 0.0, size.height);
    }
    return Rect.fromLTWH(0.0, 0.0, size.width, size.height);
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}
