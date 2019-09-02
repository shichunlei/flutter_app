import 'package:flutter/material.dart';
import 'package:custom_widgets/custom_widgets.dart';

class FlipperWidget extends StatefulWidget {
  @override
  _FlipperWidgetState createState() => _FlipperWidgetState();
}

class _FlipperWidgetState extends State<FlipperWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Flipper Widget'),
        ),
        body: Column(children: <Widget>[
          Expanded(
              child: FlipCard(
                  front: CardOne(),
                  back: CardTwo(),
                  direction: FlipDirection.HORIZONTAL)),
          Expanded(
              child: FlipCard(
                  front: CardOne(),
                  back: CardTwo(),
                  direction: FlipDirection.VERTICAL))
        ]));
  }
}

class CardOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.red,
      child: Container(
        width: 300,
        height: 200,
        child: Center(
          child: Text(
            "Tap to see the code",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
            ),
          ),
        ),
      ),
    );
  }
}

class CardTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      child: Container(
        width: 300,
        height: 200,
        child: Center(
          child: Text(
            "356789",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 35.0,
            ),
          ),
        ),
      ),
    );
  }
}
