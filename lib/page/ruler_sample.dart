import 'package:flutter/material.dart';
import 'package:custom_widgets/custom_widgets.dart';

class RulerSample extends StatefulWidget {
  RulerSample({Key key}) : super(key: key);

  @override
  createState() => _RulerSampleState();
}

class _RulerSampleState extends State<RulerSample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Rulers Example')),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(mainAxisSize: MainAxisSize.min, children: <
                        Widget>[
                      Text('Normal Scale',
                          style: Theme.of(context).textTheme.headline6),
                      Container(
                          margin: const EdgeInsets.only(top: 8.0),
                          child: RulerWidget(
                              scaleSize: 100,
                              scaleColor: Colors.grey[100],
                              indicatorWidget: Column(children: <Widget>[
                                Icon(Icons.arrow_drop_down, color: Colors.red)
                              ]),
                              limit: 24,
                              interval: 3,
                              normalBarColor: Colors.grey)),
                      Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Text('In and Out Range Scale',
                              style: Theme.of(context).textTheme.headline6)),
                      Container(
                          margin: const EdgeInsets.only(top: 8.0),
                          child: RulerWidget(
                              scaleSize: 100,
                              scaleColor: Colors.grey[100],
                              indicatorWidget: Column(children: <Widget>[
                                Icon(Icons.arrow_drop_down, color: Colors.red)
                              ]),
                              limit: 24,
                              interval: 3,
                              lowerLimit: 2,
                              midLimitLower: 2,
                              midLimitUpper: 6,
                              upperLimit: 6,
                              normalBarColor: Colors.grey,
                              inRangeBarColor: Colors.green,
                              behindRangeBarColor: Colors.orangeAccent,
                              outRangeBarColor: Colors.red)),
                      Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Text('In,Out,Mid Range Scale',
                              style: Theme.of(context).textTheme.headline6)),
                      Container(
                          margin: const EdgeInsets.only(top: 8.0),
                          child: RulerWidget(
                              scaleSize: 100,
                              scaleColor: Colors.yellow,
                              indicatorWidget: Icon(Icons.arrow_drop_down,
                                  color: Colors.red),
                              limit: 24,
                              interval: 3,
                              lowerLimit: 2,
                              midLimitLower: 4,
                              midLimitUpper: 7,
                              upperLimit: 8,
                              normalBarColor: Colors.grey,
                              inRangeBarColor: Colors.green,
                              behindRangeBarColor: Colors.orangeAccent,
                              outRangeBarColor: Colors.red)),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Text(
                          'Custom Marker Scale',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 8.0),
                          child: RulerWidget(
                              scaleSize: 100,
                              scaleColor: Colors.blue[100],
                              indicatorWidget: Image.asset('assets/marker.png',
                                  color: Colors.red, height: 25, width: 25),
                              limit: 24,
                              interval: 3,
                              lowerLimit: 2,
                              midLimitLower: 2,
                              midLimitUpper: 7,
                              upperLimit: 7,
                              normalBarColor: Colors.grey,
                              inRangeBarColor: Colors.green,
                              behindRangeBarColor: Colors.orangeAccent,
                              outRangeBarColor: Colors.red)),
                      Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Text('Horizontal Scale',
                              style: Theme.of(context).textTheme.headline6)),
                      Container(
                          margin: const EdgeInsets.only(top: 8.0),
                          alignment: Alignment.centerLeft,
                          child: RulerWidget(
                              scaleColor: Colors.grey[100],
                              scaleSize: 100,
                              indicatorWidget: Column(children: <Widget>[
                                Icon(Icons.arrow_drop_down, color: Colors.red)
                              ]),
                              limit: 20,
                              interval: 4,
                              lowerLimit: 0,
                              midLimitLower: 0,
                              midLimitUpper: 0,
                              upperLimit: 0,
                              normalBarColor: Colors.grey,
                              inRangeBarColor: Colors.green,
                              behindRangeBarColor: Colors.orangeAccent,
                              outRangeBarColor: Colors.red,
                              axis: Axis.vertical))
                    ])))));
  }
}
