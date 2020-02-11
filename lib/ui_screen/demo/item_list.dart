import 'package:flutter/material.dart';

class ItemList extends StatelessWidget {
 final VoidCallback onTap;

  ItemList({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text('张三'), trailing: Icon(Icons.chevron_right), onTap: onTap);
  }
}
