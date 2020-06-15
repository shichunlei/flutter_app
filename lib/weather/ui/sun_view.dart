import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bean/he_weather.dart';

import '../../page_index.dart';
import 'sunrise_sunset_painter.dart';

class SunView extends StatefulWidget {
  final String cityName;

  SunView(this.cityName, {Key key}) : super(key: key);

  @override
  createState() => _SunViewState();
}

class _SunViewState extends State<SunView>
    with AutomaticKeepAliveClientMixin<SunView> {
  @override
  bool get wantKeepAlive => true;

  HeWeather weather;
  SunriseSunset sunriseSunset;

  int totalMin = 0;
  int progressMin = 0;

  @override
  void initState() {
    super.initState();

    getSunData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
        margin: EdgeInsets.only(top: 10.0),
        color: Color(0x2a000000),
        padding: EdgeInsets.all(10.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('日出日落', style: TextStyle(color: Colors.white)),
              Line(),
              Container(
                  height: 160,
                  child: sunriseSunset == null
                      ? Center()
                      : SunriseSunsetView(
                          progress: totalMin == 0 ? 0 : progressMin / totalMin),
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10)),
              Row(children: <Widget>[
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(Feather.sunrise, color: Colors.white),
                      Text('日出${sunriseSunset?.sr}',
                          style: TextStyle(color: Colors.white))
                    ]),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(Feather.sunset, color: Colors.white),
                      Text('日落${sunriseSunset?.ss}',
                          style: TextStyle(color: Colors.white))
                    ]),
              ], mainAxisAlignment: MainAxisAlignment.spaceBetween)
            ]));
  }

  void getSunData() async {
    weather = await ApiService.getSunriseSunset(widget.cityName);

    setState(() {
      sunriseSunset = weather.sunriseSunset[0];

      String nowTime = formatDate(DateTime.now(), formats: [HH, ':', nn]);

      /// 当前时间
      int currentHour = int.parse('${nowTime.substring(0, 2)}');
      int currentMin = int.parse('${nowTime.substring(3)}');

      /// 日落
      int ssHour = int.parse('${sunriseSunset.ss.substring(0, 2)}');
      int ssMin = int.parse('${sunriseSunset.ss.substring(3)}');

      /// 日出
      int srHour = int.parse('${sunriseSunset.sr.substring(0, 2)}');
      int srMin = int.parse('${sunriseSunset.sr.substring(3)}');

      /// 日出到日落间的总时间（分钟）
      totalMin = (ssHour - srHour) * 60 + (ssMin - srMin);

      if (currentHour - ssHour > 0 && currentMin - ssMin > 0) {
        /// 当前时间太阳已经下山
        progressMin = totalMin;
      } else if (currentHour - srHour < 0 && currentMin - srMin < 0) {
        /// 太阳还未升起
        progressMin = 0;
      } else {
        /// 太阳已经升起
        progressMin = (currentHour - srHour) * 60 + (currentMin - srMin);
      }
    });
  }
}
