import 'package:flutter/material.dart';
import 'package:flutter_app/bean/he_weather.dart';

import '../../page_index.dart';

class AirView extends StatelessWidget {
  final Air air;

  AirView(this.air, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      color: Color(0x2a000000),
      padding: EdgeInsets.all(10.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
          Widget>[
        Text('空气质量指数', style: TextStyle(color: Colors.white)),
        Line(),
        Container(
            alignment: Alignment.center,
            height: 150,
            child: CircleProgressWidget(
                progress: double.parse(air?.aqi) / 500,
                strokeWidth: 15.0,
                labelFontSize: 40.0,
                progressColor: air?.aqiColor,
                totalDegree: 270,
                label: '${air?.aqi}')),
        Row(children: <Widget>[
          Expanded(
            child: Row(children: <Widget>[
              Icon(CustomIcon.pm25, color: Colors.white, size: 20.0),
              SizedBox(width: 5.0),
              Text('  ${air?.pm25} μg/m3',
                  style: TextStyle(color: Colors.white))
            ]),
          ),
          Expanded(
            child: Row(children: <Widget>[
              Icon(CustomIcon.pm25, color: Colors.white, size: 20.0),
              SizedBox(width: 5.0),
              Text('  ${air?.pm10} μg/m3',
                  style: TextStyle(color: Colors.white))
            ]),
          )
        ]),
        Line(),
        Row(children: <Widget>[
          Expanded(
            child: Row(children: <Widget>[
              Icon(CustomIcon.o3, color: Colors.white, size: 20.0),
              SizedBox(width: 5.0),
              Text('  ${air?.o3} μg/m3', style: TextStyle(color: Colors.white))
            ]),
          ),
          Expanded(
            child: Row(children: <Widget>[
              Icon(CustomIcon.so2, color: Colors.white, size: 20.0),
              SizedBox(width: 5.0),
              Text('  ${air?.so2} μg/m3', style: TextStyle(color: Colors.white))
            ]),
          )
        ]),
        Line(),
        Row(children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Icon(CustomIcon.co, color: Colors.white, size: 20.0),
                SizedBox(width: 5.0),
                Text('  ${air?.co} mg/m3',
                    style: TextStyle(color: Colors.white))
              ],
            ),
          ),
          Expanded(
            child: Row(children: <Widget>[
              Icon(CustomIcon.no2, color: Colors.white, size: 20.0),
              SizedBox(width: 5.0),
              Text('  ${air?.no2} μg/m3', style: TextStyle(color: Colors.white))
            ]),
          )
        ]),
      ]),
    );
  }
}
