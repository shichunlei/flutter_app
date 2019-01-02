import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogWidget extends StatefulWidget {
  @override
  createState() => new DialogWidgetState();
}

class DialogWidgetState extends State<DialogWidget>
    with SingleTickerProviderStateMixin {
  // create a dialog
  SimpleDialog simpleDialog = new SimpleDialog();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Dialog Widget"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              color: Colors.blue,
              highlightColor: Colors.blue[700],
              colorBrightness: Brightness.dark,
              splashColor: Colors.grey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('提示'),
                        //标题
                        titlePadding: EdgeInsets.all(20),
                        //标题的padding值
                        content: Text('是否想放弃学习Flutter'),
                        //弹框展示主要内容
                        contentPadding: EdgeInsets.only(left: 20, right: 20),
                        //内容的padding值
                        actions: <Widget>[
                          //操作按钮数组
                          FlatButton(
                            onPressed: () {
                              print("取消");
                              Navigator.pop(context);
                            },
                            child: Text('取消'),
                          ),
                          FlatButton(
                            onPressed: () {
                              print('确定');
                              Navigator.pop(context);
                            },
                            child: Text('确定'),
                          ),
                        ],
                      );
                    });
              },
              child: Text("AlertDialog"),
            ),
            RaisedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                        title: Text('评价一下'), //标题
                        titlePadding: EdgeInsets.all(20), //标题的padding值
                        children: <Widget>[
                          //弹框中的选项
                          SimpleDialogOption(
                            //每一个选项都是一个SimpleDialogOption Widget
                            onPressed: () {
                              print('给个好评');
                              Navigator.pop(context);
                            },
                            child: Text('给好评'), //选项提示文案
                          ),
                          SimpleDialogOption(
                            onPressed: () {
                              print('残忍拒绝');
                              Navigator.pop(context);
                            },
                            child: Text('残忍拒绝'),
                          ),
                          SimpleDialogOption(
                            onPressed: () {
                              print('我有意见');
                              Navigator.pop(context);
                            },
                            child: Text('我有意见'),
                          ),
                        ],
                        contentPadding: EdgeInsets.all(0),
                      );
                    });
              },
              child: Text("SimpleDialog"),
            ),
            RaisedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return CupertinoAlertDialog(
                        title: Text('提示'), //弹框标题
                        content: Text('是否想放弃学习Flutter'), //弹框内容
                        actions: <Widget>[
                          //操作控件
                          CupertinoDialogAction(
                            onPressed: () {
                              //控件点击监听
                              print("我不会放弃的");
                              Navigator.pop(context);
                            },
                            textStyle: TextStyle(
                                fontSize: 18, color: Colors.blueAccent),
                            //按钮上的文本风格
                            child: Text('取消'), //控件显示内容
                          ),
                          CupertinoDialogAction(
                            onPressed: () {
                              print("我投降");
                              Navigator.pop(context);
                            },
                            textStyle:
                                TextStyle(fontSize: 18, color: Colors.grey),
                            child: Text('确定'),
                          ),
                        ],
                      );
                    });
              },
              child: Text("CupertinoAlertDialog"),
            ),
          ],
        ),
      ),
    );
  }
}
