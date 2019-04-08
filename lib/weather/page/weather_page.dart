import 'package:flutter/material.dart';
import 'package:flutter_app/bean/daily_forecast.dart';
import 'package:flutter_app/bean/he_weather.dart';
import 'package:flutter_app/bean/hourly.dart';
import 'package:flutter_app/bean/lifestyle.dart';
import 'package:flutter_app/service/api_service.dart';
import 'package:flutter_app/utils/loading_util.dart';
import 'package:flutter_app/bean/now.dart';
import 'package:flutter_app/weather/ui/hourly_view.dart';
import 'package:flutter_app/weather/ui/lifestyle_view.dart';
import 'package:flutter_app/weather/ui/now_view.dart';
import 'package:flutter_app/weather/ui/sun_view.dart';
import 'package:flutter_app/weather/ui/weekly_view.dart';

class WeatherPage extends StatefulWidget {
  final String cityname;

  WeatherPage(this.cityname, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => WeatherPageState();
}

class WeatherPageState extends State<WeatherPage> {
  NowBean now;
  HeWeather weather;
  List<DailyForecast> daily_forecast = [];
  List<Lifestyle> lifestyle = [];
  List<Hourly> hourly = [];

  @override
  void initState() {
    super.initState();
    _getWeather(widget.cityname);
  }

  /// 根据城市名查询该城市天气预报
  _getWeather(String cityname) async {
    weather = await ApiService.getHeWeather(cityname);

    setState(() {
      if (weather != null) {
        now = weather.now;
        daily_forecast = weather.daily_forecast;
        lifestyle = weather.lifestyle;
        hourly = weather.hourly;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset('images/weather_bg.jpg', fit: BoxFit.fitHeight),
          _buildContentView(),
        ],
      ),
    );
  }

  Widget _buildContentView() {
    if (null == weather) {
      return getLoadingWidget();
    }
    return SingleChildScrollView(
      primary: true,
      child: Container(
        child: Column(
          children: <Widget>[
            NowView(now, daily_forecast),
            HourlyView(hourly),
            WeeklyView(daily_forecast),
            LifestyleView(lifestyle),
            SunView(this.widget.cityname),
          ],
        ),
      ),
    );
  }
}
