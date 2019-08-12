import 'package:flutter/material.dart';
import 'package:flutter_app/bean/he_weather.dart';

import '../../page_index.dart';

import '../ui/air_view.dart';
import '../ui/hourly_view.dart';
import '../ui/lifestyle_view.dart';
import '../ui/now_view.dart';
import '../ui/sun_view.dart';
import '../ui/weekly_view.dart';

class WeatherPage extends StatefulWidget {
  final String cityName;

  WeatherPage(this.cityName, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => WeatherPageState();
}

class WeatherPageState extends State<WeatherPage> {
  HeWeather weather;
  HeWeather air;

  AirNowCity airNowCity;
  NowBean now;
  List<DailyForecast> dailyForecast = [];
  List<Lifestyle> lifestyle = [];
  List<Hourly> hourly = [];

  String background = 'images/weather_backgrounds/back_100d.jpg';

  ScrollController scrollController = ScrollController();
  double navAlpha = 0;
  double headerHeight = 200;

  Color barColor = Colors.transparent;

  bool favorite = false;

  IconData _favoriteIcon = Icons.favorite_border;

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

    _getWeather(widget.cityName);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  /// 根据城市名查询该城市天气预报
  _getWeather(String cityName) async {
    air = await ApiService.getAir(cityName);
    weather = await ApiService.getHeWeather(cityName);

    if (weather != null) {
      now = weather.now;

      background = weatherBg(now?.cond_code);
      barColor = await Utils.getImageDominantColor(background, type: "asset");

      dailyForecast = weather.daily_forecast;
      lifestyle = weather.lifestyle;
      hourly = weather.hourly;
    }
    if (air != null) {
      airNowCity = air.air_now_city;
    }

    setState(() {});
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
                title: Text('${widget.cityName}'),
                elevation: 0.0,
                backgroundColor: Color.fromARGB((navAlpha * 255).toInt(),
                    barColor.red, barColor.green, barColor.blue),
                actions: <Widget>[
                  IconButton(
                      icon: Icon(_favoriteIcon, color: Colors.white),
                      onPressed: () {
                        _toggleFavorite();

                        ///
                        /// pushNewPage(context, CityPage());
                      })
                ]))
      ]),
    );
  }

  Widget _buildContentView() {
    if (null == weather || air == null) {
      return getLoadingWidget();
    }
    return RefreshIndicator(
        child: SingleChildScrollView(
            controller: scrollController,
            child: Column(children: <Widget>[
              NowView(now, dailyForecast: dailyForecast[0], air: airNowCity),
              airNowCity == null ? Container() : AirView(airNowCity),
              HourlyView(hourly),
              WeeklyView(dailyForecast),
              LifestyleView(lifestyle),
              SunView(this.widget.cityName)
            ])),
        onRefresh: () => _getWeather(widget.cityName));
  }

  void _toggleFavorite() {
    setState(() {
      if (favorite) {
        favorite = false;
        _favoriteIcon = Icons.favorite_border;
      } else {
        favorite = true;
        _favoriteIcon = Icons.favorite;
      }
    });
  }
}
