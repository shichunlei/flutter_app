import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../page_index.dart';

class BottomSheetWidget extends StatefulWidget {
  BottomSheetWidget({Key key}) : super(key: key);

  @override
  createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Flutter BottomSheet"),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.redAccent,
          child: const Icon(Icons.add, semanticLabel: 'Add')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  _scaffoldKey.currentState
                      .showBottomSheet((context) {
                        return Container(
                          height: 100.0,
                          color: Colors.greenAccent,
                          child: Center(
                            child: Text("Hi ModalSheet"),
                          ),
                        );
                      })
                      .closed
                      .whenComplete(() {
                        if (mounted) {}
                      });
                },
                child: Text("Persistent 1"),
              ),
              Gaps.vGap10,
              Builder(
                builder: (context) => RaisedButton(
                  onPressed: () {
                    showBottomSheet(
                        context: context,
                        builder: (builder) {
                          return _bottomSheetItem(context);
                        }).closed.whenComplete(() {});
                  },
                  child: Text("Persistent 2"),
                ),
              ),
              Gaps.vGap10,
              RaisedButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (builder) {
                        return _bottomSheetItem(context);
                      });
                },
                child: Text("Modal"),
              ),
              Gaps.vGap10,
              RaisedButton(
                onPressed: () {
                  var names = ['魏祖', '蓝二', '江姐', '江舅', '瑶妹'];
                  showCupertinoModalPopup(
                      context: context,
                      builder: (cxt) {
                        return Container(
                          height: 200,
                          child: CupertinoPicker(
                              itemExtent: 40,
                              onSelectedItemChanged: (position) {
                                print('The position is ${names[position]}');
                              },
                              children: names.map((e) {
                                return Text(e);
                              }).toList()),
                        );
                      });
                },
                child: Text("CupertinoPicker"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomSheetItem(BuildContext context) {
    return ListView(
      // 生成一个列表选择器
      children: List.generate(
        20,
        (index) => ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text('${index + 1}'),
          ),
          title: Text('Item ${index + 1}'),
          onTap: () {
            print('tapped item ${index + 1}');
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
