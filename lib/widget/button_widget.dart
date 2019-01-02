import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  @override
  createState() => new ButtonWidgetState();
}

class ButtonWidgetState extends State<ButtonWidget> {
  /// add line
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      /// add line
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Button Widget"),
      ),
      body: Center(
        child: Column(
          children: builderButton(context),
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ),
    );
  }

  List<Widget> builderButton(context) {
    return <Widget>[
      RaisedButton(
        color: Colors.blue,
        highlightColor: Colors.blue[700],
        colorBrightness: Brightness.dark,
        splashColor: Colors.grey,
        child: Text("Submit"),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        onPressed: () {
          // onPressed不为null视为可点击
          print('You click the raised button');
        },
      ),
      RaisedButton(
        onPressed: () {
          // onPressed不为null视为可点击
          print('You click the button');
        },
        textColor: Colors.white,
        // 文本颜色
        color: Colors.blueAccent,
        // 按钮颜色
        highlightColor: Colors.lightBlue,
        //点击按钮后高亮的颜色
        elevation: 5,
        // 按钮图层高度
        highlightElevation: 8,
        // 点击按钮高亮后的图层高度
        animationDuration: Duration(milliseconds: 300),
        // 点击按钮后过渡动画时间
        child: Text('ClickButton'),
      ),
      CupertinoButton(
        child: Text(
          'CupertinoButton',
          style: TextStyle(color: Colors.orange),
        ),
        disabledColor: Colors.blueGrey, //不可点击时按钮颜色，color属性不设置该值无效
        onPressed: null, // onPressed为null视为不可点击
      ),
      CupertinoButton(
        child: Text('CupertinoButton'),
        color: Colors.lightBlue,
        minSize: 20.0,
        disabledColor: Colors.blueGrey,
        //不可点击时按钮颜色，color属性不设置该值无效
        onPressed: null, // onPressed为null视为不可点击
      ),
      CupertinoButton(
        child: Text(
          'CupertinoButton',
          textAlign: TextAlign.center,
        ),
        color: Colors.lightBlue, // 按钮颜色
        borderRadius: BorderRadius.all(Radius.circular(15.0)), // 按钮圆角设置
        onPressed: () {
          // onPressed不为null视为可点击
          print('You click the cupertino button');
        },
      ),
      FlatButton(
        child: Text("FlatButton"),
        onPressed: () {
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text('Are you talkin\' to me?'),
            ),
          );
        },
      ),
      OutlineButton(
        child: Text("OutlineButton"),
        onPressed: () {
          _displaySnackBar();
        },
      ),
      IconButton(
        icon: Icon(Icons.thumb_down),
        onPressed: () {
          // onPressed不为null视为可点击
          print('You click the icon button');
        },
      )
    ];
  }

  void _displaySnackBar() {
    /// show snackbar
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        /// set content of snackbar
        content: Text(
          "Hello! I am SnackBar :)",
        ),

        /// set duration
        duration: Duration(seconds: 3),

        /// set the action
        action: SnackBarAction(
          label: "Hit Me (Action)",
          onPressed: () {
            /// When action button is pressed, show another snackbar
            _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text(
                  "Hello! I am shown becoz you pressed Action :)",
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
