import 'package:flutter/material.dart';
import 'package:flutter_app/utils/utils.dart';

class ItemTag extends StatelessWidget {
  final String tag;

  ItemTag({Key key, this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(tag, style: TextStyle(color: Colors.white)),
      backgroundColor: Utils.strToColor(tag),
    );
  }
}
