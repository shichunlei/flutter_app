import 'package:flutter/material.dart';
import 'package:flutter_app/ui/code_input_text.dart';

class CodeInputViewPage extends StatefulWidget {
  CodeInputViewPage({Key key}) : super(key: key);

  @override
  createState() => _CodeInputViewPageState();
}

class _CodeInputViewPageState extends State<CodeInputViewPage> {
  var _length = 6; //验证码长度，输入框框的个数
  var _type = CodeInputType.squareBox;
  double _sliderProcess = 6.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(title: Text('验证码登录')),
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(height: 30),
                Text("输入短信验证码", style: TextStyle(fontSize: 30)),
                Container(height: 30),
                Text("短信验证码至 131 9999 9999",
                    style: TextStyle(fontSize: 16, color: Colors.grey)),
                Container(height: 30),
                CodeInputText(
                    length: _length,
                    type: _type,
                    callBack: (String value) {
                      print(value);
                      if (value.length == _length) {
                        showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  content: Text('填入的验证码是$value'),
                                  actions: <Widget>[
                                    FlatButton(
                                        child: Text('OK'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        })
                                  ]);
                            });
                      }
                    }),
                Container(height: 30),
                Text("60秒后重新发送",
                    style: TextStyle(fontSize: 16, color: Colors.grey)),
                Container(height: 30),
                Text('样式', style: TextStyle(fontSize: 16)),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(children: <Widget>[
                        Radio(
                            value: CodeInputType.squareBox,
                            groupValue: _type,
                            onChanged: (v) {
                              _type = v;
                              setState(() {});
                            }),
                        Text('方框')
                      ]),
                      Row(children: <Widget>[
                        Radio(
                            value: CodeInputType.underLine,
                            groupValue: _type,
                            onChanged: (v) {
                              _type = v;
                              setState(() {});
                            }),
                        Text('下划线')
                      ])
                    ]),
                Container(height: 10),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(children: <Widget>[
                        Radio(
                            value: CodeInputType.circle,
                            groupValue: _type,
                            onChanged: (v) {
                              _type = v;
                              setState(() {});
                            }),
                        Text('圆框')
                      ]),
                      Row(children: <Widget>[
                        Radio(
                            value: CodeInputType.round,
                            groupValue: _type,
                            onChanged: (v) {
                              _type = v;
                              setState(() {});
                            }),
                        Text('圆角')
                      ])
                    ]),
                Container(height: 30),
                Text('验证码长度  $_length', style: TextStyle(fontSize: 16)),
                Slider(
                    max: 6.0,
                    min: 4.0,
                    divisions: 2,
                    value: _sliderProcess,
                    onChanged: (v) {
                      _sliderProcess = v;
                      setState(() {});
                    },
                    onChangeEnd: (v) {
                      _length = v.toInt();
                      setState(() {});
                    })
              ],
            )) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
