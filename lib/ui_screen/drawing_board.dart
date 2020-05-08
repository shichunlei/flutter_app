import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui show ImageByteFormat, Image;

import 'package:flutter_app/utils/file_util.dart';

/// Description: 签名画板并截图
///
class DrawingBoardPage extends StatefulWidget {
  @override
  createState() => _DrawingBoardPageState();
}

class _DrawingBoardPageState extends State<DrawingBoardPage> {
  /// 标记签名画板的Key，用于截图
  GlobalKey _globalKey = GlobalKey();

  /// 已描绘的点
  List<Offset> _points = [];

  /// 记录截图的本地保存路径
  String _imageLocalPath;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Drawing Board')),
        body: Container(
            margin: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 0.0),
            child: Column(children: <Widget>[
              Container(
                  height: 180.0,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 0.5)),
                  child: RepaintBoundary(
                      key: _globalKey,
                      child: Stack(children: [
                        GestureDetector(
                            onPanUpdate: (details) => _addPoint(details),
                            onPanEnd: (details) => _points.add(null)),
                        CustomPaint(painter: BoardPainter(_points))
                      ]))),
              Row(children: <Widget>[
                RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () async {
                      setState(() {
                        _points?.clear();
                        _points = [];
                        _imageLocalPath = null;
                      });
                    },
                    child:
                        Text('CLEAR', style: TextStyle(color: Colors.white))),
                Spacer(),
                RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () async {
                      String toPath = await _capturePng();
                      print('Signature Image Path: $toPath');
                      setState(() {
                        _imageLocalPath = toPath;
                      });
                    },
                    child: Text('SCREEN SHOT',
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.white,
                            fontWeight: FontWeight.normal)))
              ]),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: 4.0),
                  child: Text('Image local path:')),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: 4.0),
                  child: Text(_imageLocalPath ?? '',
                      style: TextStyle(color: Colors.blue))),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: 4.0),
                  child: Text('Show Image: ')),
              Container(
                  height: 180.0,
                  margin: EdgeInsets.only(top: 4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 0.5)),
                  child: Image.file(File(_imageLocalPath ?? '')))
            ])));
  }

  /// 添加点，注意不要超过Widget范围
  _addPoint(DragUpdateDetails details) {
    RenderBox referenceBox = _globalKey.currentContext.findRenderObject();
    Offset localPosition = referenceBox.globalToLocal(details.globalPosition);
    double maxW = referenceBox.size.width;
    double maxH = referenceBox.size.height;
    // 校验范围
    if (localPosition.dx <= 0 || localPosition.dy <= 0) return;
    if (localPosition.dx > maxW || localPosition.dy > maxH) return;
    setState(() {
      _points = List.from(_points)..add(localPosition);
    });
  }

  /// 截图，并且返回图片的缓存地址
  ///
  Future<String> _capturePng() async {
    File toFile = await FileUtil.getInstance().getPathFile(
        "${DateTime.now().millisecondsSinceEpoch}.png");

    // 1. 获取 RenderRepaintBoundary
    RenderRepaintBoundary boundary =
        _globalKey.currentContext.findRenderObject();
    // 2. 生成 Image
    ui.Image image = await boundary.toImage();
    // 3. 生成 Uint8List
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    // 4. 本地存储Image
    toFile.writeAsBytes(pngBytes);
    return toFile.path;
  }
}

class BoardPainter extends CustomPainter {
  BoardPainter(this.points);

  final List<Offset> points;

  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0
      ..isAntiAlias = true;
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  bool shouldRepaint(BoardPainter other) => true;
}
