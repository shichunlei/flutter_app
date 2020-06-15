import 'package:flutter/material.dart';

class TweenAnimationBuilderDemo extends StatefulWidget {
  TweenAnimationBuilderDemo({Key key}) : super(key: key);

  @override
  createState() => _TweenAnimationBuilderDemoState();
}

class _TweenAnimationBuilderDemoState extends State<TweenAnimationBuilderDemo> {
  Color _colorValue = Colors.orange;

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
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('TweenAnimationBuilderDemo')),
      body: Center(
        child: TweenAnimationBuilder<Color>(
          duration: Duration(seconds: 3),
          builder: (BuildContext context, Color value, Widget child) {
            return ColorFiltered(
              colorFilter: ColorFilter.mode(
                value,
                BlendMode.modulate,
              ),
              child: Container(
                height: 100,
                width: 100,
                color: value,
              ),
            );
          },
          tween: ColorTween(
            begin: Colors.white,
            end: _colorValue,
          ),
          onEnd: () {
            print('onEnd');
            setState(() {
              _colorValue = Colors.blue;
            });
          },
        ),
      ),
    );
  }
}
