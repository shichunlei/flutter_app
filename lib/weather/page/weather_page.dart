import 'package:flutter/material.dart';
import 'package:flutter_app/bean/air_now_city.dart';
import 'package:flutter_app/bean/daily_forecast.dart';
import 'package:flutter_app/bean/he_weather.dart';
import 'package:flutter_app/bean/hourly.dart';
import 'package:flutter_app/bean/lifestyle.dart';
import 'package:flutter_app/global/data.dart';
import 'package:flutter_app/service/api_service.dart';
import 'package:flutter_app/utils/loading_util.dart';
import 'package:flutter_app/bean/now.dart';
import 'package:flutter_app/utils/route_util.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_app/weather/page/city_page.dart';
import 'package:flutter_app/weather/ui/air_view.dart';
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
  HeWeather weather;
  HeWeather air;

  AirNowCity air_now_city;
  NowBean now;
  List<DailyForecast> daily_forecast = [];
  List<Lifestyle> lifestyle = [];
  List<Hourly> hourly = [];

  String background = 'images/weather_bg.jpg';

  ScrollController scrollController = ScrollController();
  double navAlpha = 0;
  double headerHeight = 200;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      var offset = scrollController.offset;
      if (offset < 0) {
        if (navAlpha != 0) {
          setState(() {
            navAlpha = 0;
          });
        }
      } else if (offset < headerHeight) {
        setState(() {
          navAlpha = 1 - (headerHeight - offset) / headerHeight;
        });
      } else if (navAlpha != 1) {
        setState(() {
          navAlpha = 1;
        });
      }
    });

    _getWeather(widget.cityname);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  /// 根据城市名查询该城市天气预报
  _getWeather(String cityname) async {
    air = await ApiService.getAir(cityname);
    weather = await ApiService.getHeWeather(cityname);
    setState(() {
      if (weather != null) {
        now = weather.now;
        background = weatherBg(now?.cond_code);
        daily_forecast = weather.daily_forecast;
        lifestyle = weather.lifestyle;
        hourly = weather.hourly;
      }
      if (air != null) {
        air_now_city = air.air_now_city;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Image.asset(background, fit: BoxFit.fitHeight, height: double.infinity),
        _buildContentView(),
        Container(
            height: Utils.navigationBarHeight,
            child: AppBar(
                centerTitle: true,
                title: Text('${widget.cityname}'),
                elevation: 0.0,
                backgroundColor:
                    Color.fromARGB((navAlpha * 255).toInt(), 239, 83, 80),
                actions: <Widget>[
                  IconButton(
                      icon: Icon(Icons.blur_on, color: Colors.white),
                      onPressed: () => pushNewPage(context, CityPage()))
                ]))
      ]),
    );
  }

  Widget _buildContentView() {
    if (null == weather) {
      return getLoadingWidget();
    }
    return SingleChildScrollView(
        controller: scrollController,
        child: Column(children: <Widget>[
          NowView(now,
              daily_forecast: daily_forecast[0], air_now_city: air_now_city),
          AirView(air_now_city),
          HourlyView(hourly),
          WeeklyView(daily_forecast),
          LifestyleView(lifestyle),
          SunView(this.widget.cityname)
        ]));
  }
}
