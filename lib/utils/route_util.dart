import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void pushAndRemovePage(BuildContext context, Widget routePage) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => routePage),
    (route) => route == null,
  );
}

void pushNewPage(BuildContext context, Widget routePage) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => routePage));
}

void pushNewPageBack(BuildContext context, Widget routePage) {
  Navigator.of(context)
      .push(CupertinoPageRoute(builder: (context) => routePage));
}

void popAndPushNewPage(BuildContext context, String routeName) {
  Navigator.popAndPushNamed(context, routeName);
}

void pushReplacement(BuildContext context, Widget routePage) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => routePage));
}

void pushReplacementName(BuildContext context, String routeName) {
  Navigator.pushReplacementNamed(context, routeName);
}
