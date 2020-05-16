import 'package:flutter/material.dart';

class ReorderableListViewWidget extends StatefulWidget {
  const ReorderableListViewWidget({Key key}) : super(key: key);

  @override
  createState() => _ReorderableListViewWidgetState();
}

class _ReorderableListViewWidgetState extends State<ReorderableListViewWidget> {
  List<int> list = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 100; i++) {
      list.add(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: ReorderableListView(
                children: list
                    .map((i) =>
                        ListTile(key: ValueKey("$i"), title: Text('Item $i')))
                    .toList(),
                header: Text('This is the header!'),
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    _updateMyItems(oldIndex, newIndex);
                  });
                })));
  }

  void _updateMyItems(int oldIndex, int newIndex) {
    var tmp = list[oldIndex];
    list[oldIndex] = list[newIndex];
    list[newIndex] = tmp;
  }
}
