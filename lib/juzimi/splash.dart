import 'package:flutter/material.dart';
import 'package:flutter_app/juzimi/juzimi_home.dart';
import 'package:flutter_app/utils/route_util.dart';

class SplashPage extends StatelessWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Image.asset("images/splash.png", fit: BoxFit.fitWidth),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                      icon: Icon(Icons.close, color: Colors.grey),
                      onPressed: () => Navigator.pop(context)),
                  margin: EdgeInsets.only(top: 30),
                ),
                Container(
                    child: Column(children: <Widget>[
                      Text('摘 ~ 抄', style: TextStyle(fontSize: 20.0)),
                      SizedBox(height: 20),
                      Text('你喜欢 的 每一句', style: TextStyle(fontSize: 20.0))
                    ]),
                    margin: EdgeInsets.only(top: 100))
              ]),
              Container(
                  child: RaisedButton(
                      color: Colors.white,
                      elevation: 0.0,
                      onPressed: () =>
                          pushReplacement(context, JuzimiHomePage()),
                      child: Text('进入',
                          style:
                              TextStyle(fontSize: 30.0, color: Colors.grey))),
                  margin: EdgeInsets.only(bottom: 50.0))
            ],
          )
        ],
      ),
    );
  }
}
