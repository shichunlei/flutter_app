import 'package:flutter/material.dart';
import 'package:flutter_app/bean/he_weather.dart';
import 'package:flutter_app/bean/sunrise_sunset.dart';
import 'package:flutter_app/service/api_service.dart';

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
      width: double.infinity,
      color: Color(0x2a000000),
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('日出日落', style: TextStyle(color: Colors.white)),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            height: 0.2,
            width: double.infinity,
            color: Colors.white,
          ),
          Container(
            child: sunrise_sunset == null
                ? null
                : Container(
                    child: Text('日出：${sunrise_sunset.sr}------日落${sunrise_sunset.ss}'),
                    height: 100.0,
                  ),
          )
        ],
      ),
    );
  }

  void getSunData() async {
    weather = await ApiService.getSunriseSunset(widget.cityname);

    setState(() {
      sunrise_sunset = weather.sunrise_sunset[0];
    });
  }
}
