/**
 * 使用Dismissible组件实现右滑删除
 * 它是根据Key来删除ListView中的某一项的
 * 请注意ListView.builder中itemBuilder: (context, index)传进的index
 * 它不是list中的下标，而是这个组件在当前屏幕上所占的位置
 */

import 'package:flutter/material.dart';

class DismissibleWidget extends StatefulWidget {
  DismissibleWidget({Key key}) : super(key: key);

  @override
  createState() => _DismissibleWidgetState();
}

class _DismissibleWidgetState extends State<DismissibleWidget> {
  List<String> items = new List<String>.generate(30, (i) => "Item ${(i + 1)}");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('侧滑删除'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final item = items[index];
          return Dismissible(
            key: Key(item),
            onDismissed: (direction) {
              setState(() {
                items.removeAt(index);
              });
            },
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    child: Icon(
                      Icons.fiber_manual_record,
                      color: Colors.white,
                    ),
                    backgroundColor: Colors.amber,
                  ),
                  title: Text('$item'),
                  subtitle: Text('Pull to refresh.\nSwipe to dismiss.'),
                  onTap: () {},
                ),
                Container(
                  height: 1.0,
                  color: Colors.grey[200],
                ),
              ],
            ),
            background: Container(
              color: Colors.red,
              child: const ListTile(
                leading: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ),
            secondaryBackground: Container(
              color: Colors.red,
              child: const ListTile(
                trailing: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
        itemCount: items.length,
      ),
    );
  }
}
