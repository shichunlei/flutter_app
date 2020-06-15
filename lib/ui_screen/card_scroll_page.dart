import 'dart:math';

import 'package:flutter/material.dart';

import '../page_index.dart';

/// https://github.com/devefy/Flutter-Story-App-UI/blob/master/lib/main.dart

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

List<String> images = [
  "images/weather_backgrounds/back_100d.jpg",
  "images/weather_backgrounds/back_100n.jpg",
  "images/weather_backgrounds/back_101d.jpg",
  "images/weather_backgrounds/back_101n.jpg",
];

List<String> title = [
  "Hounted Ground",
  "Fallen In Love",
  "The Dreaming Moon",
  "Jack the Persian and the Black Castel",
];

class CardScrollDemo extends StatefulWidget {
  CardScrollDemo({Key key}) : super(key: key);

  @override
  createState() => _CardScrollDemoState();
}

class _CardScrollDemoState extends State<CardScrollDemo> {
  var currentPage = images.length - 1.0;

  PageController controller;

  @override
  void initState() {
    super.initState();

    controller = PageController(initialPage: images.length - 1)
      ..addListener(() {
        setState(() {
          currentPage = controller.page;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xFF1b1e44), Color(0xFF2d3447)],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                tileMode: TileMode.clamp)),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Stack(children: <Widget>[
                CardScrollWidget(currentPage),
                Positioned.fill(
                    child: PageView.builder(
                        itemCount: images.length,
                        controller: controller,
                        reverse: true,
                        itemBuilder: (context, index) => Container()))
              ]),
            )));
  }
}

class CardScrollWidget extends StatelessWidget {
  final num currentPage;

  CardScrollWidget(this.currentPage);

  @override
  Widget build(BuildContext context) {
    var padding = 20.0;
    var verticalInset = 20.0;

    return new AspectRatio(
        aspectRatio: widgetAspectRatio,
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          var width = constraints.maxWidth;
          var height = constraints.maxHeight;

          var safeWidth = width - 2 * padding;
          var safeHeight = height - 2 * padding;

          var heightOfPrimaryCard = safeHeight;
          var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

          var primaryCardLeft = safeWidth - widthOfPrimaryCard;
          var horizontalInset = primaryCardLeft / 2;

          List<Widget> cardList = new List();

          for (var i = 0; i < images.length; i++) {
            var delta = i - currentPage;
            bool isOnRight = delta > 0;

            var start = padding +
                max(
                    primaryCardLeft -
                        horizontalInset * -delta * (isOnRight ? 15 : 1),
                    0.0);

            var cardItem = Positioned.directional(
                top: padding + verticalInset * max(-delta, 0.0),
                bottom: padding + verticalInset * max(-delta, 0.0),
                start: start,
                textDirection: TextDirection.rtl,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(3.0, 6.0),
                                  blurRadius: 10.0)
                            ]),
                        child: AspectRatio(
                          aspectRatio: cardAspectRatio,
                          child: Stack(fit: StackFit.expand, children: <Widget>[
                            Image.asset(images[i], fit: BoxFit.cover),
                            Align(
                                alignment: Alignment.bottomLeft,
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16.0, vertical: 8.0),
                                          child: Text(title[i],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 25.0))),
                                      Gaps.vGap10,
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              left: 12.0, bottom: 12.0),
                                          child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 22.0,
                                                  vertical: 6.0),
                                              decoration: BoxDecoration(
                                                  color: Colors.blueAccent,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0)),
                                              child: Text("Read Later",
                                                  style: TextStyle(
                                                      color: Colors.white))))
                                    ]))
                          ]),
                        ))));
            cardList.add(cardItem);
          }
          return Stack(children: cardList);
        }));
  }
}
