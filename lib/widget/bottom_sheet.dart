import 'package:flutter/material.dart';

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
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
              ),
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
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
              ),
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
