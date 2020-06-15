import 'package:flutter/material.dart';
import 'package:clippy_flutter/clippy_flutter.dart';

import '../page_index.dart';

class ClippyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Clippy')),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: SingleChildScrollView(
          child: Center(
            child: Wrap(
              spacing: 2.0,
              runSpacing: 4.0,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                Diagonal(
                  clipHeight: 20.0,
                  axis: Axis.horizontal,
                  position: DiagonalPosition.BOTTOM_LEFT,
                  child: Container(
                    color: Utils.strToColor("Diagonal"),
                    width: 100.0,
                    height: 80.0,
                    child: Center(child: Text('Diagonal')),
                  ),
                ),
                Gaps.vGap8,
                Chevron(
                  triangleHeight: 50.0,
                  edge: Edge.RIGHT,
                  child: Container(
                    color: Utils.strToColor("Chevron"),
                    width: 70.0,
                    height: 100.0,
                    child: Center(child: Text('Chevron')),
                  ),
                ),
                Gaps.vGap8,
                Ticket(
                  radius: 10.0,
                  child: Container(
                    color: Utils.strToColor("Ticket"),
                    width: 100.0,
                    height: 50.0,
                    child: Center(child: Text('Ticket')),
                  ),
                ),
                Gaps.vGap8,
                ButtCheek(
                  height: 10.0,
                  child: Container(
                    color: Utils.strToColor("ButtCheek"),
                    width: 100.0,
                    height: 100.0,
                    child: Center(child: Text('ButtCheek')),
                  ),
                ),
                Gaps.vGap8,
                Triangle.isosceles(
                  edge: Edge.TOP,
                  child: Container(
                    color: Utils.strToColor("Triangle"),
                    width: 100.0,
                    height: 100.0,
                    child: Center(child: Text('Triangle')),
                  ),
                ),
                Gaps.vGap8,
                Arrow(
                  triangleHeight: 30.0,
                  rectangleClipHeight: 10.0,
                  edge: Edge.RIGHT,
                  child: Container(
                    color: Utils.strToColor("Arrow"),
                    width: 100.0,
                    height: 50.0,
                    child: Center(child: Text('Arrow')),
                  ),
                ),
                Gaps.vGap8,
                Message(
                  child: Container(
                    color: Utils.strToColor("Message"),
                    width: 100.0,
                    height: 100.0,
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Text('Message'),
                    )),
                  ),
                  triangleX1: 60.0,
                  triangleX2: 80.0,
                  triangleX3: 80.0,
                  triangleY1: 20.0,
                ),
                Gaps.vGap8,
                Trapezoid(
                  cutLength: 15.0,
                  edge: Edge.TOP,
                  child: Container(
                    color: Utils.strToColor("Trapezoid"),
                    width: 100.0,
                    height: 100.0,
                    child: Center(child: Text('Trapezoid')),
                  ),
                ),
                Gaps.vGap8,
                Arc(
                  edge: Edge.BOTTOM,
                  arcType: ArcType.CONVEX,
                  height: 20.0,
                  child: Container(
                    color: Utils.strToColor("Arc"),
                    width: 100.0,
                    height: 50.0,
                    child: Center(child: Text('Arc')),
                  ),
                ),
                Gaps.vGap8,
                Bevel(
                  cutLength: 10.0,
                  child: Container(
                    color: Utils.strToColor("Bevel"),
                    width: 100.0,
                    height: 100.0,
                    child: Center(child: Text('Bevel')),
                  ),
                ),
                Gaps.vGap8,
                Rabbet(
                  cutLength: 10.0,
                  child: Container(
                    color: Utils.strToColor("Rabbet"),
                    width: 100.0,
                    height: 100.0,
                    child: Center(child: Text('Rabbet')),
                  ),
                ),
                Gaps.vGap8,
                Point(
                  triangleHeight: 30.0,
                  edge: Edge.LEFT,
                  child: Container(
                    color: Utils.strToColor("Point"),
                    width: 100.0,
                    height: 100.0,
                    child: Center(child: Text('Point')),
                  ),
                ),
                Gaps.vGap8,
                Parallelogram(
                  cutLength: 10.0,
                  edge: Edge.RIGHT,
                  child: Container(
                    color: Utils.strToColor("Paralelogram"),
                    width: 100.0,
                    height: 100.0,
                    child: Center(child: Text('Paralelogram')),
                  ),
                ),
                Gaps.vGap8,
                Polygon(
                  sides: 5,
                  child: Container(
                    color: Utils.strToColor("Polygon"),
                    width: 100.0,
                    height: 100.0,
                    child: Center(child: Text('Polygon')),
                  ),
                ),
                Gaps.vGap8,
                Label(
                  triangleHeight: 10.0,
                  edge: Edge.RIGHT,
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 18.0, top: 8.0, bottom: 8.0),
                    color: Colors.green,
                    child: Text('Label'),
                  ),
                ),
                Gaps.vGap8,
                Rhombus(
                  child: Container(
                    color: Utils.strToColor("Rhombus"),
                    width: 100.0,
                    height: 100.0,
                    child: Center(child: Text('Rhombus')),
                  ),
                ),
                Star(
                  child: Container(
                    color: Utils.strToColor("Star"),
                    width: 100.0,
                    height: 100.0,
                    child: Center(child: Text('Star')),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
