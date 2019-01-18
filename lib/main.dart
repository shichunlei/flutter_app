import 'package:flutter/material.dart';
import 'package:flutter_app/intro_slide_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  /// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Flutter Demo",

      /// 您可以通过配置ThemeData类轻松更改应用程序的主题
      theme: ThemeData(primaryColor: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: IntroSlidePage(),
    );
  }
}
