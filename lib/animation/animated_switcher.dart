import 'package:flutter/material.dart';

class AnimatedSwitcherSample extends StatefulWidget {
  AnimatedSwitcherSample({Key key}) : super(key: key);

  @override
  createState() => _AnimatedSwitcherSampleState();
}

class _AnimatedSwitcherSampleState extends State<AnimatedSwitcherSample> {
  IconData _actionIcon = Icons.delete;

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
        body: null);
  }
}
