import 'package:flutter/material.dart';
import 'package:flutter_app/bean/he_weather.dart';
import 'package:flutter_app/bean/sunrise_sunset.dart';
import 'package:flutter_app/custom_widgets/sunrise_sunset_view.dart';
import 'package:flutter_app/global/custom_icon.dart';
import 'package:flutter_app/service/api_service.dart';
import 'package:flutter_app/utils/time_utils.dart';
import 'package:flutter_app/ui/line.dart';

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

  int totalMin = 0;
  int progressMin = 0;

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
            Container(
                height: 160,
                child: sunrise_sunset == null
                    ? Center()
                    : SunriseSunsetView(
                        progress: totalMin == 0 ? 0 : progressMin / totalMin),
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10)),
            Row(children: <Widget>[
              Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(CustomIcon.sunrise, color: Colors.white, size: 15),
                    Text('日出${sunrise_sunset?.sr}',
                        style: TextStyle(color: Colors.white))
                  ]),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(CustomIcon.sunset, color: Colors.white, size: 15),
                    Text('日落${sunrise_sunset?.ss}',
                        style: TextStyle(color: Colors.white))
                  ]),
            ], mainAxisAlignment: MainAxisAlignment.spaceBetween)
          ]),
    );
  }

  void getSunData() async {
    weather = await ApiService.getSunriseSunset(widget.cityname);

    setState(() {
      sunrise_sunset = weather.sunrise_sunset[0];

      totalMin = (int.parse('${sunrise_sunset?.ss.substring(0, 2)}') -
                  int.parse('${sunrise_sunset?.sr.substring(0, 2)}')) *
              60 +
          (int.parse('${sunrise_sunset?.ss.substring(3)}') -
              int.parse('${sunrise_sunset?.sr.substring(3)}'));

      String nowTime = TimeUtils.getDateStrByDateTime(DateTime.now(),
          format: DateFormat.HOUR_MINUTE);

      progressMin = (int.parse('${nowTime.substring(0, 2)}') -
                  int.parse('${sunrise_sunset?.sr.substring(0, 2)}')) *
              60 +
          (int.parse('${nowTime.substring(3)}') -
              int.parse('${sunrise_sunset?.sr.substring(3)}'));
    });
  }
}
