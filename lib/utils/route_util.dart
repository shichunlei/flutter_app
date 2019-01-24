import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void pushAndRemovePage(BuildContext context, Widget newPage) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(
      builder: (context) => newPage,
    ),
    (route) => route == null,
  );
}

void pushNewPage(BuildContext context, Widget newPage) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => newPage));
}

void pushNewPageBack(BuildContext context, Widget newPage) {
  Navigator.of(context).push(CupertinoPageRoute(builder: (context) => newPage));
}
