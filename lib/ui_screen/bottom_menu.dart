import 'package:flutter/material.dart';

class BottomMenuPage extends StatefulWidget {
  createState() => _BottomMenuPageState();
}

class _BottomMenuPageState extends State<BottomMenuPage>
    with SingleTickerProviderStateMixin {
  bool menuShown = false;
  Animation<double> animation;
  AnimationController controller;

  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);
    animation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.bounceOut,
        reverseCurve: Curves.bounceIn))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            menuShown = !menuShown;
          });
        }
        if (status == AnimationStatus.dismissed) {
          setState(() {
            menuShown = !menuShown;
          });
        }
      });
  }

  _handleMenuPress() {
    if (menuShown) {
      controller.reverse();
    } else {
      controller.forward();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(menuShown ? Icons.keyboard_arrow_down : Icons.menu),
            onPressed: _handleMenuPress),
        title: Text(menuShown ? "Menu" : "Home"),
        elevation: 0.0,
      ),
      body: Stack(fit: StackFit.expand, children: <Widget>[
        Container(
          color: Colors.pink,
          height: animation.value,
        ),
        LayoutBuilder(
          builder: (context, constraints) => Container(
            margin:
                EdgeInsets.only(top: animation.value * constraints.maxHeight),
            child: Material(
              color: Colors.white,
              elevation: 16.0,
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(46.0)),
              ),
              child: ListView.builder(
                padding: EdgeInsets.only(top: 60.0),
                itemBuilder: (_, int index) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(index.toString()),
                    ),
                    title: Text("List item $index"),
                    onTap: () {},
                  );
                },
                itemCount: 60,
              ),
            ),
          ),
        )
      ]),
    );
  }
}
