import 'package:flutter/material.dart';

class DraggableWidget extends StatefulWidget {
  const DraggableWidget({Key key}) : super(key: key);

  @override
  createState() => _DraggableWidgetState();
}

class _DraggableWidgetState extends State<DraggableWidget> {
  List<String> _items1 = List<String>.generate(10, (it) => 'item $it');
  List<String> _items2 = List<String>.generate(10, (it) => 'item $it');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(title: Text('Draggable')),
        body: Column(children: <Widget>[
          _createGridView(_items1),
          SizedBox(height: 100),
          DragTarget<String>(builder: (
            BuildContext context,
            List<dynamic> candidateData,
            List<dynamic> rejectedData,
          ) {
            return _createGridView(_items2);
          }, onAccept: (String data) {
            setState(() {
              _items2.add(data);
            });
          })
        ]));
  }

  Widget _createGridView(List<String> _items) {
    return GridView.builder(
        itemCount: _items.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5, mainAxisSpacing: 10, crossAxisSpacing: 10),
        itemBuilder: (context, index) {
          return Draggable<String>(
              onDragCompleted: () {
                // 在拖动结束后删除数据
                setState(() {
                  _items.removeAt(index);
                });
              },
              childWhenDragging: Container(
                  color: Colors.blueAccent,
                  alignment: Alignment.center,
                  foregroundDecoration: BoxDecoration(color: Colors.white30),
                  child: Text(_items[index],
                      style: TextStyle(color: Colors.white))),
              feedback: Material(
                  child: Container(
                      height: 70,
                      width: 70,
                      color: Colors.blueAccent,
                      alignment: Alignment.center,
                      child: Text(_items[index],
                          style: TextStyle(color: Colors.white)))),
              // 当前组件的数据
              data: _items[index],
              child: Container(
                  color: Colors.blueAccent,
                  alignment: Alignment.center,
                  child: Text(_items[index],
                      style: TextStyle(color: Colors.white))));
        });
  }
}
