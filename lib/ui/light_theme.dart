import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../page_index.dart';

class LightTheme extends StatelessWidget {
  final Widget child;

  LightTheme({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
            accentColor: readerMainColor,
            primaryColor: readerMainColor,
            scaffoldBackgroundColor: Colors.grey[200],
            appBarTheme: AppBarTheme(
                iconTheme: lightIconTheme,
                elevation: 0.0,
                systemOverlayStyle: SystemUiOverlayStyle.dark,
                color: Colors.white)),
        child: child);
  }
}
