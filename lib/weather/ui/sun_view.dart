import 'package:flutter/material.dart';
import 'package:flutter_app/bean/he_weather.dart';
import 'package:flutter_app/bean/sunrise_sunset.dart';
import 'package:flutter_app/global/custom_icon.dart';
import 'package:flutter_app/service/api_service.dart';
import 'package:flutter_app/weather/ui/line.dart';

class SunView extends StatefulWidget {
  final String cityname;

  SunView(this.cityname, {Key key}) : super(key: key);

  @override
  createState() => _SunViewState();
}

class _SunViewState extends State<SunView>
    with AutomaticKeepAliveClientMixin<SunView> {
  @override
  bool get wantKeepAlive => true;

  HeWeather weather;
  SunriseSunset sunrise_sunset = null;

  @override
  void initState() {
    super.initState();

    getSunData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      color: Color(0x2a000000),
      padding: EdgeInsets.all(10.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('日出日落', style: TextStyle(color: Colors.white)),
            Line(),
            Container(height: 100),
            Column(children: <Widget>[
              Line(),
              Row(children: <Widget>[
                Column(children: <Widget>[
                  Icon(CustomIcon.sun, color: Colors.white),
                  Text('日出${sunrise_sunset?.sr}',
                      style: TextStyle(color: Colors.white))
                ]),
                Column(children: <Widget>[
                  Icon(CustomIcon.moon, color: Colors.white),
                  Text('日落${sunrise_sunset?.ss}',
                      style: TextStyle(color: Colors.white))
                ]),
              ], mainAxisAlignment: MainAxisAlignment.spaceBetween)
            ])
          ]),
    );
  }

  void getSunData() async {
    weather = await ApiService.getSunriseSunset(widget.cityname);

    setState(() {
      sunrise_sunset = weather.sunrise_sunset[0];
    });
  }
}
