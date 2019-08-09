import 'package:flutter/material.dart';
import 'package:flutter_app/custom_widgets/drag_like/slide_stack.dart';
import 'package:flutter_app/utils/toast.dart';
import 'package:flutter_app/global/data.dart';

class DragLikePage extends StatefulWidget {
  @override
  createState() => _DragLikePageState();
}

class _DragLikePageState extends State<DragLikePage>
    with TickerProviderStateMixin {
  AnimationController _controller;

  int aboveIndex = 0;
  int belowIndex = 1;

  final double bottomHeight = 100.0;
  final double defaultIconSize = 30.0;
  final Color defaultIconColor =
      Color.lerp(Color(0xFFFF80AB), Color(0xFFC51162), 0.0);

  double position = 0.0;
  SlideDirection slideDirection;

  double get leftIconSize => slideDirection == SlideDirection.left
      ? defaultIconSize * (1 + position * 0.8)
      : defaultIconSize;

  double get rightIconSize => slideDirection == SlideDirection.right
      ? defaultIconSize * (1 + position * 0.8)
      : defaultIconSize;

  Color get leftIconColor => slideDirection == SlideDirection.left
      ? Color.lerp(Color(0xFFFF80AB), Color(0xFFC51162), position)
      : defaultIconColor;

  Color get rightIconColor => slideDirection == SlideDirection.right
      ? Color.lerp(Color(0xFFFF80AB), Color(0xFFC51162), position)
      : defaultIconColor;

  void setAboveIndex() {
    if (aboveIndex < Girl.girls.length - 1) {
      aboveIndex++;
    } else {
      aboveIndex = 0;
    }
  }

  void setBelowIndex() {
    if (belowIndex < Girl.girls.length - 1) {
      belowIndex++;
    } else {
      belowIndex = 0;
    }
  }

  void onSlide(double position, SlideDirection direction) {
    setState(() {
      this.position = position;
      this.slideDirection = direction;
    });
  }

  void onSlideCompleted() {
    _controller.forward();
    String isLike =
        (slideDirection == SlideDirection.left) ? 'dislike' : 'like';
    Toast.show(context, 'You $isLike this !',
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    setAboveIndex();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    )
      ..addListener(() {
        setState(() {
          if (position != 0) {
            position = 1 - _controller.value;
          }
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reset();
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drag to choose like or dislike'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: _buildCard(),
              ),
            ),
            _buildBottom(),
          ],
        ),
      ),
    );
  }

  Widget _buildCard() {
    return Stack(
      children: <Widget>[
        _buildBackground(),
        Positioned(
          child: SlideStack(
            child: _buildChooseView(Girl.girls[aboveIndex]),
            below: _buildChooseView(Girl.girls[belowIndex]),
            slideDistance: MediaQuery.of(context).size.width - 40.0,
            onSlide: onSlide,
            onSlideCompleted: onSlideCompleted,
            refreshBelow: setBelowIndex,
            rotateRate: 0.4,
          ),
          left: 10.0,
          top: 20.0,
          bottom: 40.0,
          right: 10.0,
        ),
      ],
    );
  }

  Widget _buildChooseView(Girl girl) {
    return Stack(
      children: <Widget>[
        Positioned(
          child: Image.network(
            girl.image,
            fit: BoxFit.cover,
          ),
          left: 35.0,
          right: 35.0,
          top: 20.0,
          bottom: 50.0,
        ),
        Positioned(
          child: Text(
            girl.description,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          left: 10.0,
          right: 10.0,
          bottom: 10.0,
        ),
      ],
    );
  }

  Stack _buildBackground() {
    return Stack(
      children: <Widget>[
        Positioned(
          child: Card(
            child: Text('test'),
          ),
          left: 40.0,
          top: 40.0,
          bottom: 10.0,
          right: 40.0,
        ),
        Positioned(
          child: Card(
            child: Text('test'),
          ),
          left: 30.0,
          top: 30.0,
          bottom: 20.0,
          right: 30.0,
        ),
        Positioned(
          child: Card(
            child: Text('test'),
          ),
          left: 20.0,
          top: 30.0,
          bottom: 30.0,
          right: 20.0,
        ),
      ],
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      height: bottomHeight,
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Row(
          children: <Widget>[
            Expanded(
                child: Icon(
              Icons.favorite_border,
              size: leftIconSize,
              color: leftIconColor,
            )),
            Expanded(
                child: Icon(
              Icons.favorite,
              size: rightIconSize,
              color: rightIconColor,
            ))
          ],
        ),
      ),
    );
  }
}
