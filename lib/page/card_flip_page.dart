import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../page_index.dart';

class CardFlipPage extends StatefulWidget {
  CardFlipPage({Key key}) : super(key: key);

  @override
  createState() => _CardFlipPageState();
}

class _CardFlipPageState extends State<CardFlipPage> {
  double scrollPercent = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(children: <Widget>[
          Expanded(
              child: CardFlipper(
                  cards: cardDataList,
                  onScroll: (double sp) {
                    setState(() {
                      this.scrollPercent = sp;
                    });
                  })),
          BottomBar(
              cardCount: cardDataList.length, scrollPercent: scrollPercent)
        ], mainAxisAlignment: MainAxisAlignment.center));
  }
}

class CardFlipper extends StatefulWidget {
  CardFlipper({this.cards, this.onScroll});

  final List<CardData> cards;
  final Function(double scrollPercent) onScroll;

  @override
  createState() => _CardFlipper();
}

class _CardFlipper extends State<CardFlipper> with TickerProviderStateMixin {
  double scrollPercent = 0.0;
  Offset startDrag;
  double startDragPercentScroll;
  double finishScrollStart;
  double finishScrollEnd;
  AnimationController finishScrollController;
  Direction direction = Direction.LEFT;

  @override
  void initState() {
    super.initState();
    finishScrollController =
        AnimationController(duration: Duration(milliseconds: 150), vsync: this)
          ..addListener(() {
            setState(() {
              scrollPercent = ui.lerpDouble(finishScrollStart, finishScrollEnd,
                  finishScrollController.value);
              widget.onScroll(scrollPercent);
            });
          });
  }

  @override
  void dispose() {
    finishScrollController?.dispose();
    super.dispose();
  }

  void _onHorizontalDragStart(DragStartDetails details) {
    startDrag = details.globalPosition;
    startDragPercentScroll = scrollPercent;
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    final currDrag = details.globalPosition;
    final dragDistance = currDrag.dx - startDrag.dx;
    final allCardDragDistance = dragDistance / context.size.width;
    final numCards = widget.cards.length;
    if (allCardDragDistance > 0) {
      direction = Direction.LEFT;
    } else {
      direction = Direction.RIGHT;
    }
    setState(() {
      scrollPercent =
          (startDragPercentScroll + (-allCardDragDistance / numCards))
              .clamp(0.0, 1.0 - (1 / numCards));
      widget.onScroll(scrollPercent);
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    final numCards = widget.cards.length;
    finishScrollStart = scrollPercent;
    if (direction == Direction.LEFT) {
      finishScrollEnd = (scrollPercent * numCards).floor() / numCards;
    } else {
      finishScrollEnd = (scrollPercent * numCards).ceil() / numCards;
    }

    finishScrollController.forward(from: 0.0);
    setState(() {
      startDrag = null;
      startDragPercentScroll = null;
    });
  }

  List<Widget> _buildCards() {
    int i = -1;
    return widget.cards.map<Widget>((cardData) {
      i++;
      return _buildCard(cardData, i, widget.cards.length, scrollPercent);
    }).toList();
  }

  Widget _buildCard(
      CardData cardData, int cardIndex, int cardCount, double scrollPercent) {
    final cardScrollPercent = scrollPercent * cardCount;
    final parallax = scrollPercent - (cardIndex / cardCount);

    return FractionalTranslation(
        translation: Offset(cardIndex - cardScrollPercent, 0.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CardView(data: cardData, parallaxPercent: parallax),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onHorizontalDragStart: _onHorizontalDragStart,
        onHorizontalDragUpdate: _onHorizontalDragUpdate,
        onHorizontalDragEnd: _onHorizontalDragEnd,
        behavior: HitTestBehavior.translucent,
        child: Stack(children: _buildCards()));
  }
}

class CardView extends StatefulWidget {
  CardView({@required this.data, this.parallaxPercent = 0.0});

  final CardData data;
  final double parallaxPercent;

  @override
  createState() => _CardState();
}

class _CardState extends State<CardView> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.expand, children: <Widget>[
      ClipRect(
          child: FractionalTranslation(
              translation: Offset(widget.parallaxPercent * 2.0, 0.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: Image.asset(widget.data.asset, fit: BoxFit.cover)))),
      Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Text(widget.data.name,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                    fontFamily: "petita"))),
        Expanded(child: Container()),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(widget.data.time,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 100.0,
                      letterSpacing: -5.0)),
              Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 8.0),
                  child: Text(widget.data.tag,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold)))
            ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Icon(widget.data.icon, color: Colors.white),
          Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(widget.data.place,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0)))
        ]),
        Expanded(child: Container()),
        Padding(
            padding: const EdgeInsets.only(top: 50.0, bottom: 50.0),
            child: Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 0.8, color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    color: Colors.black.withOpacity(0.3)),
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 6.0, horizontal: 20.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(widget.data.desc,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0))
                        ]))))
      ])
    ]);
  }
}

class BottomBar extends StatefulWidget {
  BottomBar({this.cardCount, this.scrollPercent});

  final int cardCount;
  final double scrollPercent;

  @override
  createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
        child: Row(children: <Widget>[
          Expanded(
              child: Center(child: Icon(Icons.settings, color: Colors.white))),
          Expanded(
              child: Container(
                  width: double.infinity,
                  height: 5.0,
                  child: ScrollIndicator(
                      cardCount: widget.cardCount,
                      scrollPercent: widget.scrollPercent))),
          Expanded(child: Center(child: Icon(Icons.add, color: Colors.white)))
        ]));
  }
}

class CardData {
  String asset;
  String name;
  String time;
  String tag;
  IconData icon;
  String place;
  String desc;

  CardData(this.asset, this.name, this.time, this.tag, this.icon, this.place,
      this.desc);
}

List<CardData> cardDataList = [
  CardData("images/weather_backgrounds/back_100d.jpg", "江中树", "7 : 30", "AM",
      Icons.wb_sunny, "天府之地", "青山绿水"),
  CardData("images/weather_backgrounds/back_100n.jpg", "浮云", "12 : 20", "PM",
      Icons.cloud, "天堂", "浮兰藏青"),
  CardData("images/weather_backgrounds/back_101d.jpg", "路", "9 : 40", "AM",
      Icons.beach_access, "凡间", "平凡之路"),
  CardData("images/weather_backgrounds/back_101n.jpg", "船", "16 : 30", "PM",
      Icons.brightness_2, "幽冥", "白云苍狗"),
];
