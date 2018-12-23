import 'package:flutter/material.dart';
import 'package:flutter_app/firstdemo/random_words.dart';
import 'package:flutter_app/movie/list/movie_list_page.dart';
import 'package:flutter_app/widget/button_widget.dart';
import 'package:flutter_app/widget/image_widget.dart';
import 'package:flutter_app/widget/text_widget.dart';
import 'package:flutter_app/widget/textfield_widget.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      // 您可以通过配置ThemeData类轻松更改应用程序的主题。 您的应用程序目前使用默认主题，下面将更改primary color颜色为白色。
      theme: new ThemeData(primaryColor: Colors.blue),
      home: new MovieListPage(),
    );
  }
}
