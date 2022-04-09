import 'package:flutter/material.dart';

import '../page_index.dart';

class RouteSample extends StatelessWidget {
  RouteSample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Route Sample')),
      body: ListView(
        children: <Widget>[
          ElevatedButton(
            child: Text('MaterialPageRoute'),
            onPressed: () => pushNewPage(context, SecondPage()),
          ),
          ElevatedButton(
            child: Text('CupertinoPageRoute'),
            onPressed: () => pushNewPageBack(context, SecondPage()),
          ),
          ElevatedButton(
            child: Text('Slide L2R'),
            onPressed: () => pushNewPageAnimation(context, SecondPage(),
                type: TransitionType.slide_right),
          ),
          ElevatedButton(
            child: Text('Slide R2L'),
            onPressed: () => pushNewPageAnimation(context, SecondPage(),
                type: TransitionType.slide_left),
          ),
          ElevatedButton(
            child: Text('Slide B2T'),
            onPressed: () => pushNewPageAnimation(context, SecondPage(),
                type: TransitionType.slide_top),
          ),
          ElevatedButton(
            child: Text('Slide T2B'),
            onPressed: () => pushNewPageAnimation(context, SecondPage(),
                type: TransitionType.slide_bottom),
          ),
          ElevatedButton(
            child: Text('EnterExit R2L'),
            onPressed: () => pushNewPageAnimation(context, SecondPage(),
                type: TransitionType.enter_exit, fromPage: this),
          ),
          ElevatedButton(
            child: Text('EnterExit L2R'),
            onPressed: () => pushNewPageAnimation(context, SecondPage(),
                type: TransitionType.enter_exit,
                fromPage: this,
                direction: SlideDirection.left2right),
          ),
          ElevatedButton(
            child: Text('EnterExit T2B'),
            onPressed: () => pushNewPageAnimation(context, SecondPage(),
                type: TransitionType.enter_exit,
                fromPage: this,
                direction: SlideDirection.top2bottom),
          ),
          ElevatedButton(
            child: Text('EnterExit B2T'),
            onPressed: () => pushNewPageAnimation(context, SecondPage(),
                type: TransitionType.enter_exit,
                fromPage: this,
                direction: SlideDirection.bottom2top),
          ),
          ElevatedButton(
            child: Text('ScaleRotate'),
            onPressed: () => pushNewPageAnimation(context, SecondPage(),
                type: TransitionType.scale_rotate),
          ),
          ElevatedButton(
            child: Text('Rotation'),
            onPressed: () => pushNewPageAnimation(context, SecondPage(),
                type: TransitionType.rotate),
          ),
          ElevatedButton(
            child: Text('Scale'),
            onPressed: () => pushNewPageAnimation(context, SecondPage(),
                type: TransitionType.scale),
          ),
          ElevatedButton(
            child: Text('Size vertical'),
            onPressed: () => pushNewPageAnimation(context, SecondPage(),
                type: TransitionType.size),
          ),
          ElevatedButton(
            child: Text('Size horizontal'),
            onPressed: () => pushNewPageAnimation(context, SecondPage(),
                type: TransitionType.size, axis: Axis.horizontal),
          ),
          ElevatedButton(
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
        child: ElevatedButton(
          child: Text('Go Back!'),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
}
