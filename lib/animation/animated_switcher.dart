import 'package:flutter/material.dart';

class AnimatedSwitcherSample extends StatefulWidget {
  AnimatedSwitcherSample({Key key}) : super(key: key);

  @override
  createState() => _AnimatedSwitcherSampleState();
}

class _AnimatedSwitcherSampleState extends State<AnimatedSwitcherSample> {
  IconData _actionIcon = Icons.delete;

  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(title: Text('AnimatedSwitcherSample'), actions: <Widget>[
          AnimatedSwitcher(

              /// 动画持续时间
              duration: Duration(milliseconds: 300),

              /// 设置一个新的转换动画
              transitionBuilder: (child, anim) =>
                  FadeTransition(child: child, opacity: anim),
              child: IconButton(
                  icon: Icon(_actionIcon),
                  onPressed: () {
                    setState(() {
                      if (_actionIcon == Icons.delete)
                        _actionIcon = Icons.done;
                      else
                        _actionIcon = Icons.delete;
                    });
                  },
                  key: ValueKey<IconData>(_actionIcon)))
        ]),
        body: Center(
            child: AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  //执行缩放动画
                  return ScaleTransition(child: child, scale: animation);
                },
                child: Text('$_count',
                    //显示指定key，不同的key会被认为是不同的Text，这样才能执行动画
                    key: ValueKey<int>(_count),
                    style: Theme.of(context).textTheme.headline1))),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
                _count += 1;
              });
            },
            child: Icon(Icons.add)));
  }
}
