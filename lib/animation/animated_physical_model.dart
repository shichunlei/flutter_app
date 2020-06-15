import 'package:flutter/material.dart';

class AnimatedPhysicalModelDemo extends StatefulWidget {
  AnimatedPhysicalModelDemo({Key key}) : super(key: key);

  @override
  createState() => _AnimatedPhysicalModelDemoState();
}

class _AnimatedPhysicalModelDemoState extends State<AnimatedPhysicalModelDemo> {
  var isShadow = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(title: Text('AnimatedPhysicalModel')),
        body: Center(
          child: AnimatedPhysicalModel(
            curve: Curves.fastOutSlowIn,

            /// 背景色
            color: Colors.grey.withOpacity(0.2),

            /// 阴影的裁剪方式。Clip.none：无模式；Clip.hardEdge：裁剪速度稍快，但容易失真，有锯齿；Clip.antiAlias：裁剪边缘抗锯齿，使得裁剪更平滑，这种模式裁剪速度比antiAliasWithSaveLayer快，但是比hardEdge慢；Clip.antiAliasWithSaveLayer：裁剪后具有抗锯齿特性并分配屏幕缓冲区，所有后续操作在缓冲区进行
            clipBehavior: Clip.antiAliasWithSaveLayer,

            /// 背景的边框
            borderRadius: BorderRadius.circular(22.0),

            /// 背景色是否用动画形式展示
            animateColor: true,

            /// 阴影是否用动画形式展示
            animateShadowColor: true,

            /// 阴影的形状
            shape: BoxShape.rectangle,

            /// 阴影的动画值
            shadowColor: isShadow ? Colors.red : Colors.blue,

            /// 阴影颜色值的深度
            elevation: 5.0,

            /// 动画时间
            duration: Duration(milliseconds: 300),
            child: Container(
              width: 250,
              height: 200,
              child: Text("AnimatedPhysicalModelDemo"),
              alignment: Alignment.center,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() => isShadow = !isShadow);
            },
            child: Icon(Icons.brush)));
  }
}
