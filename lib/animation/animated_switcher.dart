import 'package:flutter/material.dart';

class AnimatedSwitcherSample extends StatefulWidget {
  AnimatedSwitcherSample({Key key}) : super(key: key);

  @override
  createState() => _AnimatedSwitcherSampleState();
}

class _AnimatedSwitcherSampleState extends State<AnimatedSwitcherSample> {
  IconData _actionIcon = Icons.delete;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('AnimatedSwitcherSample'),
        actions: <Widget>[
          AnimatedSwitcher(
            /// 动画持续时间
            duration: Duration(milliseconds: 300),

            /// 设置一个新的转换动画
            transitionBuilder: (child, anim) {
              return FadeTransition(
                child: child,
                opacity: anim,
              );
            },
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
              key: ValueKey(_actionIcon),
            ),
          )
        ],
      ),
      body: Container(),
    );
  }
}
