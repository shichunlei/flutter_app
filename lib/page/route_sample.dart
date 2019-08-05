import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/custom_widgets/routes/enter_exit_route.dart';
import 'package:flutter_app/custom_widgets/routes/rotation_route.dart';
import 'package:flutter_app/custom_widgets/routes/scale_rotate_route.dart';
import 'package:flutter_app/custom_widgets/routes/scale_route.dart';
import 'package:flutter_app/custom_widgets/routes/size_route.dart';
import 'package:flutter_app/custom_widgets/routes/slide_route.dart';

class RouteSample extends StatelessWidget {
  RouteSample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Route Sample')),
      backgroundColor: Colors.blue,
      body: SizedBox(
        width: double.infinity,
        child: ListView(children: <Widget>[
          RaisedButton(
            child: Text('MaterialPageRoute'),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => SecondPage())),
          ),
          RaisedButton(
            child: Text('CupertinoPageRoute'),
            onPressed: () => Navigator.push(context,
                CupertinoPageRoute(builder: (context) => SecondPage())),
          ),
          RaisedButton(
            child: Text('SlideRightTransition'),
            onPressed: () => Navigator.push(
                context,
                SlideRoute(
                    page: SecondPage(), direction: SlideDirection.right)),
          ),
          RaisedButton(
            child: Text('SlideLeftTransition'),
            onPressed: () => Navigator.push(context,
                SlideRoute(page: SecondPage(), direction: SlideDirection.left)),
          ),
          RaisedButton(
            child: Text('SlideTopTransition'),
            onPressed: () => Navigator.push(context,
                SlideRoute(page: SecondPage(), direction: SlideDirection.top)),
          ),
          RaisedButton(
            child: Text('SlideBottomTransition'),
            onPressed: () => Navigator.push(
                context,
                SlideRoute(
                    page: SecondPage(), direction: SlideDirection.bottom)),
          ),
          RaisedButton(
            child: Text('EnterExitSlideTransition'),
            onPressed: () => Navigator.push(context,
                EnterExitRoute(exitPage: this, enterPage: SecondPage())),
          ),
          RaisedButton(
            child: Text('ScaleRotateTransition'),
            onPressed: () =>
                Navigator.push(context, ScaleRotateRoute(page: SecondPage())),
          ),
          RaisedButton(
            child: Text('RotationTansition'),
            onPressed: () =>
                Navigator.push(context, RotationRoute(page: SecondPage())),
          ),
          RaisedButton(
            child: Text('ScaleTransition'),
            onPressed: () =>
                Navigator.push(context, ScaleRoute(page: SecondPage())),
          ),
          RaisedButton(
            child: Text('SizeTransition'),
            onPressed: () =>
                Navigator.push(context, SizeRoute(page: SecondPage())),
          )
        ]),
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
