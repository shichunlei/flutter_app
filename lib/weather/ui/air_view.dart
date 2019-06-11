import 'package:flutter/material.dart';
import 'package:flutter_app/bean/he_weather.dart';
import 'package:flutter_app/custom_widgets/circle_progress.dart';
import 'package:flutter_app/global/custom_icon.dart';
import 'package:flutter_app/ui/line.dart';

class AirView extends StatelessWidget {
  final AirNowCity air_now_city;

  AirView(this.air_now_city, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      color: Color(0x2a000000),
      padding: EdgeInsets.all(10.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('空气质量指数', style: TextStyle(color: Colors.white)),
            Line(),
            Container(
                alignment: Alignment.center,
                height: 150,
                child: CircleProgressWidget(
                    progress: double.parse(air_now_city.aqi) / 500,
                    strokeWidth: 15.0,
                    lableFontSize: 40.0,
                    progressColor: air_now_city.aqiColor,
                    totalDegree:270,
                    lable: '${air_now_city.aqi}')),
            Row(children: <Widget>[
              Expanded(
                child: Row(children: <Widget>[
                  Icon(CustomIcon.pm25, color: Colors.white, size: 20.0),
                  SizedBox(width: 5.0),
                  Text('  ${air_now_city?.pm25} μg/m3',
                      style: TextStyle(color: Colors.white))
                ]),
              ),
              Expanded(
                child: Row(children: <Widget>[
                  Icon(CustomIcon.pm25, color: Colors.white, size: 20.0),
                  SizedBox(width: 5.0),
                  Text('  ${air_now_city?.pm10} μg/m3',
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
                  Text('  ${air_now_city?.o3} μg/m3',
                      style: TextStyle(color: Colors.white))
                ]),
              ),
              Expanded(
                child: Row(children: <Widget>[
                  Icon(CustomIcon.so2, color: Colors.white, size: 20.0),
                  SizedBox(width: 5.0),
                  Text('  ${air_now_city?.so2} μg/m3',
                      style: TextStyle(color: Colors.white))
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
                    Text('  ${air_now_city?.co} mg/m3',
                        style: TextStyle(color: Colors.white))
                  ],
                ),
              ),
              Expanded(
                child: Row(children: <Widget>[
                  Icon(CustomIcon.no2, color: Colors.white, size: 20.0),
                  SizedBox(width: 5.0),
                  Text('  ${air_now_city?.no2} μg/m3',
                      style: TextStyle(color: Colors.white))
                ]),
              )
            ]),
          ]),
    );
  }
}
