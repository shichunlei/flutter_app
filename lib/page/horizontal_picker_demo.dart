import 'package:flutter/material.dart';

import '../page_index.dart';

class HorizontalPickerDemo extends StatefulWidget {
  HorizontalPickerDemo({Key key}) : super(key: key);

  @override
  createState() => _HorizontalPickerDemoState();
}

class _HorizontalPickerDemoState extends State<HorizontalPickerDemo> {
  double newValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: Text('')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            height: 120,
            child: HorizontalPicker(
              minValue: 0,
              maxValue: 10,
              divisions: 10,
              onChanged: (value) {},
              style: CursorStyle.triangle,
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            height: 120,
            child: HorizontalPicker(
              minValue: 0,
              maxValue: 10,
              divisions: 10,
              suffix: " ℃",
              showCursor: false,
              backgroundColor: Colors.lightBlue.shade50,
              activeItemTextColor: Colors.blue.shade800,
              passiveItemsTextColor: Colors.blue.shade300,
              onChanged: (value) {},
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            height: 120,
            child: HorizontalPicker(
              minValue: -10,
              maxValue: 55,
              divisions: 600,
              suffix: " cm",
              showCursor: false,
              backgroundColor: Colors.grey.shade900,
              activeItemTextColor: Colors.white,
              passiveItemsTextColor: Colors.amber,
              onChanged: (value) {
                setState(() {
                  newValue = value;
                });
              },
            ),
          ),
          Text(newValue.toString())
        ],
      ),
    );
  }
}
