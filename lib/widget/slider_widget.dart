import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../page_index.dart';

class SliderWidget extends StatefulWidget {
  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  double _value = 25.0;
  double _discreteValue = 20.0;
  double value = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Slider Widget'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          Text('${_value.toInt()}'),
          Gaps.vGap15,
          Slider(
            value: _value,
            min: 0.0,
            max: 100.0,
            onChanged: (double value) => setState(() => _value = value),
            activeColor: Colors.redAccent,
            inactiveColor: Colors.orangeAccent,
          ),
          const Text('Continuous'),
          Gaps.vGap15,
          Slider(value: 0.25, onChanged: null),
          const Text('Disabled'),
          Gaps.vGap15,
          Slider(
            value: _discreteValue,
            min: 0.0,
            max: 100.0,
            divisions: 100,
            label: '${_discreteValue.round()}',
            onChanged: (double value) {
              setState(() {
                _discreteValue = value;
              });
            },
          ),
          const Text('Discrete'),
          Gaps.vGap15,
          CupertinoSlider(
            onChanged: (double value) {
              setState(() => _value = value);
            },
            value: _value,
            max: 100,
            min: 0,
          ),
          const Text('CupertinoSlider'),
          Gaps.vGap15,
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              //已拖动的颜色
              activeTrackColor: Colors.greenAccent,
              //未拖动的颜色
              inactiveTrackColor: Colors.green,

              //提示进度的气泡的背景色
              valueIndicatorColor: Colors.green,
              //提示进度的气泡文本的颜色
              valueIndicatorTextStyle: TextStyle(
                color: Colors.white,
              ),

              //滑块中心的颜色
              thumbColor: Colors.blueAccent,
              //滑块边缘的颜色
              overlayColor: Colors.white,

              //divisions对进度线分割后，断续线中间间隔的颜色
              inactiveTickMarkColor: Colors.white,
            ),
            child: Slider(
              value: value,
              label: '$value',
              min: 0.0,
              max: 100.0,
              divisions: 100,
              onChanged: (double val) {
                setState(() {
                  value = val.floorToDouble(); //转化成double
                });
              },
            ),
          ),
          const Text('SliderTheme'),
        ],
      ),
    );
  }
}
