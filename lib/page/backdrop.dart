import 'package:flutter/material.dart';

class BackDropPage extends StatefulWidget {
  BackDropPage({Key key}) : super(key: key);

  @override
  createState() => _BackDropPageState();
}

class _BackDropPageState extends State<BackDropPage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  bool get isPanelVisible =>
      controller.status == AnimationStatus.completed ||
      controller.status == AnimationStatus.forward;

  static const header_height = 64.0;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 200), value: 1.0);
  }

  Animation<RelativeRect> getPanelAnimation(BoxConstraints constraints) {
    final height = constraints.biggest.height;
    final backPanelHeight = height - header_height;
    final frontPanelHeight = -header_height;

    return RelativeRectTween(
            begin: RelativeRect.fromLTRB(
                0.0, backPanelHeight, 0.0, frontPanelHeight),
            end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0))
        .animate(CurvedAnimation(parent: controller, curve: Curves.linear));
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0.0,
        title: Text('BackDrop'),
        leading: IconButton(
          icon: AnimatedIcon(
            icon: AnimatedIcons.close_menu,
            progress: controller.view,
          ),
          onPressed: () {
            controller.fling(velocity: isPanelVisible ? -1.0 : 1.0);
          },
        ),
      ),
      body: LayoutBuilder(
        builder: (_, BoxConstraints constraints) {
          return Container(
            child: Stack(
              children: <Widget>[
                Center(
                  child: Text(
                    "Back Panel",
                    style: TextStyle(fontSize: 24.0),
                  ),
                ),
                PositionedTransition(
                  rect: getPanelAnimation(constraints),
                  child: Material(
                    elevation: 12.0,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0)),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: header_height,
                          child: Center(
                            child: Text(
                              "Shop Here",
                              style: Theme.of(context).textTheme.button,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text("Front Panel",
                                style: TextStyle(
                                    fontSize: 24.0, color: Colors.black)),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
