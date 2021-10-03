import 'package:flutter/material.dart';

class ButtonBarDemo extends StatelessWidget {
  ButtonBarDemo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ButtonBar')),
      body: Container(
        margin: EdgeInsets.zero,
        height: 100.0,
        child: ListView(
          scrollDirection: Axis.horizontal, // 水平listView
          children: <Widget>[
            ButtonBar(
              alignment: MainAxisAlignment.spaceAround,
              //布局方向，默认MainAxisAlignment.end
              mainAxisSize: MainAxisSize.max,
              //主轴大小，默认MainAxisSize.max
              children: <Widget>[
                // Button集合
                ElevatedButton(
                  child: Text('ButtonBar1'),
                  style: ButtonStyle(backgroundColor: ButtonStyleButton.allOrNull<Color>(Colors.red)),
                  onPressed: () => {},
                ),
                ElevatedButton(
                  child: Text('ButtonBar2'),
                  style: ButtonStyle(backgroundColor: ButtonStyleButton.allOrNull<Color>(Colors.red)),
                  onPressed: () => {},
                ),
                ElevatedButton(
                  child: Text('ButtonBar3'),
                  style: ButtonStyle(backgroundColor: ButtonStyleButton.allOrNull<Color>(Colors.red)),
                  onPressed: () => {},
                ),
              ],
            ),
            ButtonBar(
              alignment: MainAxisAlignment.end,
              //布局方向，默认MainAxisAlignment.end
              mainAxisSize: MainAxisSize.min,
              //主轴大小，默认MainAxisSize.max
              children: <Widget>[
                // Button集合
                ElevatedButton(
                  child: Text('ButtonBar1'),
                  style: ButtonStyle(backgroundColor: ButtonStyleButton.allOrNull<Color>(Colors.yellow)),
                  onPressed: () => {},
                ),
                ElevatedButton(
                  child: Text('ButtonBar2'),
                  style: ButtonStyle(backgroundColor: ButtonStyleButton.allOrNull<Color>(Colors.yellow)),
                  onPressed: () => {},
                ),
                ElevatedButton(
                  child: Text('ButtonBar3'),
                  style: ButtonStyle(backgroundColor: ButtonStyleButton.allOrNull<Color>(Colors.yellow)),
                  onPressed: () => {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
