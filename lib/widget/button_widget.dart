import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  @override
  createState() => new ButtonWidgetState();
}

class ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: Text("Button Widget"),
      ),
      body: new Center(
        child: new Column(
          children: builderButton(),
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ),
    );
  }

  List<Widget> builderButton() {
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
      Row(
        children: <Widget>[
          Expanded(
            child: CupertinoButton(
              child: Text(
                'C',
                style: TextStyle(color: Colors.orange),
              ),
              disabledColor: Colors.blueGrey, //不可点击时按钮颜色，color属性不设置该值无效
              onPressed: null, // onPressed为null视为不可点击
            ),
          ),
          CupertinoButton(
            child: Text('Button'),
            color: Colors.lightBlue,
            minSize: 20.0,
            disabledColor: Colors.blueGrey,
            //不可点击时按钮颜色，color属性不设置该值无效
            onPressed: null, // onPressed为null视为不可点击
          ),
          Expanded(
            child: CupertinoButton(
              child: Text(
                'Click',
                textAlign: TextAlign.center,
              ),
              color: Colors.lightBlue, // 按钮颜色
              borderRadius: BorderRadius.all(Radius.circular(15.0)), // 按钮圆角设置
              onPressed: () {
                // onPressed不为null视为可点击
                print('You click the cupertino button');
              },
            ),
          ),
        ],
      ),
      FlatButton(
        child: Text("FlatButton"),
        onPressed: () {
          // onPressed不为null视为可点击
          print('You click the cupertino button');
        },
      ),
      OutlineButton(
        child: Text("OutlineButton"),
        onPressed: () {
          // onPressed不为null视为可点击
          print('You click the outline button');
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
}
