import 'package:flutter/material.dart';

import '../page_index.dart';

class DarkTheme extends StatelessWidget {
  final Widget child;

  DarkTheme({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
          brightness: Brightness.dark,
          accentColor: readerMainColor,
          primaryColor: readerMainColor,
          scaffoldBackgroundColor: Color(0xff26262d),
          iconTheme: IconThemeData(color: Colors.white),
          hintColor: Colors.grey,
          hoverColor: Colors.grey,
          focusColor: Colors.grey,
          buttonColor: Colors.grey,
          textSelectionColor: readerMainColor,
          dialogBackgroundColor: Colors.grey,
          dividerTheme: DividerThemeData(color: Colors.white54),
          appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(color: Colors.white),
              textTheme: TextTheme(
                  headline6: TextStyle(color: Colors.white, fontSize: 22)),
              elevation: 0.0,
              brightness: Brightness.dark,
              color: Color(0xff26262d)),
        ),
        child: child);
  }
}
