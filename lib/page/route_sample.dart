import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../page_index.dart';

class RouteSample extends StatelessWidget {
  RouteSample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Route Sample')),
      backgroundColor: Colors.blue,
      body: ListView(
        children: <Widget>[
          RaisedButton(
            child: Text('MaterialPageRoute'),
            onPressed: () => pushNewPage(context, SecondPage()),
          ),
          RaisedButton(
            child: Text('CupertinoPageRoute'),
            onPressed: () => pushNewPageBack(context, SecondPage()),
          ),
          RaisedButton(
            child: Text('Slide L2R'),
            onPressed: () => pushNewPageAnimation(context, SecondPage(),
                type: TransitionType.slide_right),
          ),
          RaisedButton(
            child: Text('Slide R2L'),
            onPressed: () => pushNewPageAnimation(context, SecondPage(),
                type: TransitionType.slide_left),
          ),
          RaisedButton(
            child: Text('Slide B2T'),
            onPressed: () => pushNewPageAnimation(context, SecondPage(),
                type: TransitionType.slide_top),
          ),
          RaisedButton(
            child: Text('Slide T2B'),
            onPressed: () => pushNewPageAnimation(context, SecondPage(),
                type: TransitionType.slide_bottom),
          ),
          RaisedButton(
            child: Text('EnterExit R2L'),
            onPressed: () => pushNewPageAnimation(context, SecondPage(),
                type: TransitionType.enter_exit, fromPage: this),
          ),
          RaisedButton(
            child: Text('EnterExit L2R'),
            onPressed: () => pushNewPageAnimation(context, SecondPage(),
                type: TransitionType.enter_exit,
                fromPage: this,
                direction: SlideDirection.left2right),
          ),
          RaisedButton(
            child: Text('EnterExit T2B'),
            onPressed: () => pushNewPageAnimation(context, SecondPage(),
                type: TransitionType.enter_exit,
                fromPage: this,
                direction: SlideDirection.top2bottom),
          ),
          RaisedButton(
            child: Text('EnterExit B2T'),
            onPressed: () => pushNewPageAnimation(context, SecondPage(),
                type: TransitionType.enter_exit,
                fromPage: this,
                direction: SlideDirection.bottom2top),
          ),
          RaisedButton(
            child: Text('ScaleRotate'),
            onPressed: () => pushNewPageAnimation(context, SecondPage(),
                type: TransitionType.scale_rotate),
          ),
          RaisedButton(
            child: Text('Rotation'),
            onPressed: () => pushNewPageAnimation(context, SecondPage(),
                type: TransitionType.rotate),
          ),
          RaisedButton(
            child: Text('Scale'),
            onPressed: () => pushNewPageAnimation(context, SecondPage(),
                type: TransitionType.scale),
          ),
          RaisedButton(
            child: Text('Size vertical'),
            onPressed: () => pushNewPageAnimation(context, SecondPage(),
                type: TransitionType.size),
          ),
          RaisedButton(
            child: Text('Size horizontal'),
            onPressed: () => pushNewPageAnimation(context, SecondPage(),
                type: TransitionType.size, axis: Axis.horizontal),
          ),
          RaisedButton(
            child: Text('Transform'),
            onPressed: () => pushNewPageAnimation(context, SecondPage(),
                type: TransitionType.transform),
          )
        ],
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  SecondPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SecondPage')),
      backgroundColor: Colors.green,
      body: Center(
        child: RaisedButton(
          child: Text('Go Back!'),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
}
