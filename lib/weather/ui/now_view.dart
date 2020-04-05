import 'package:flutter/material.dart';
import 'package:flutter_app/bean/he_weather.dart';
import 'package:flutter_app/global/custom_icon.dart';
import 'package:flutter_app/ui/line.dart';

class NowView extends StatelessWidget {
  final NowWeather now;
  final DailyForecast dailyForecast;
  final Air air;

  NowView(this.now, {this.dailyForecast, this.air, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0x2a000000),
      padding:
          EdgeInsets.only(top: 100.0, bottom: 10.0, left: 10.0, right: 10.0),
      child: Column(children: <Widget>[
        Text(now?.tmp, style: TextStyle(color: Colors.white, fontSize: 80.0)),
        SizedBox(height: 10.0),
        Text(now?.condTxt,
            style: TextStyle(color: Colors.white, fontSize: 17.0)),
        air == null
            ? Container()
            : FlatButton(
                color: Color(0x2a000000),
                onPressed: () {},
                child: Row(
                    children: <Widget>[
                      Icon(CustomIcon.air, color: air?.aqiColor),
                      Text('${air?.aqi}  ${air?.qlty}',
                          style: TextStyle(color: Colors.white)),
                      Icon(Icons.keyboard_arrow_right, color: Colors.white)
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min)),
        Line(),
        Row(children: <Widget>[
          Expanded(
            child: Row(children: <Widget>[
              Icon(CustomIcon.tmp, color: Colors.white, size: 20.0),
              SizedBox(width: 5.0),
              Text('${dailyForecast?.tmp_max}/${dailyForecast?.tmp_min}℃',
                  style: TextStyle(color: Colors.white))
            ]),
          ),
          Expanded(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(CustomIcon.wind, color: Colors.white, size: 20.0),
                  SizedBox(width: 5.0),
                  Text('${now?.windDir}${now?.windSc}级',
                      style: TextStyle(color: Colors.white))
                ]),
          ),
          Expanded(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Icon(CustomIcon.hum, color: Colors.white, size: 20.0),
                  SizedBox(width: 5.0),
                  Text(now?.hum, style: TextStyle(color: Colors.white))
                ]),
          )
        ]),
        Line(),
        Row(children: <Widget>[
          Expanded(
            child: Row(children: <Widget>[
              Icon(CustomIcon.pcpn, color: Colors.white, size: 20.0),
              SizedBox(width: 5.0),
              Text('  降雨量：${now?.pcpn} mm',
                  style: TextStyle(color: Colors.white))
            ]),
          ),
          Expanded(
            child: Row(children: <Widget>[
              Icon(CustomIcon.press, color: Colors.white, size: 20.0),
              SizedBox(width: 5.0),
              Text(' 大气压：${now?.pres} hPa',
                  style: TextStyle(color: Colors.white))
            ]),
          )
        ]),
        Line(),
        Row(children: <Widget>[
          Expanded(
            child: Row(children: <Widget>[
              Icon(CustomIcon.vis, color: Colors.white, size: 20.0),
              SizedBox(width: 5.0),
              Text('  能见度：${now?.vis} km',
                  style: TextStyle(color: Colors.white))
            ]),
          ),
          Expanded(
            child: Row(children: <Widget>[
              Icon(CustomIcon.cloud, color: Colors.white, size: 20.0),
              SizedBox(width: 5.0),
              Text('  云  量：${now?.cloud}',
                  style: TextStyle(color: Colors.white))
            ]),
          )
        ])
      ]),
    );
  }
}
