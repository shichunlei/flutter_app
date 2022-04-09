import 'package:flutter/material.dart';
import '../../page_index.dart';
import '../ui/air_view.dart';
import '../ui/hourly_view.dart';
import '../ui/lifestyle_view.dart';
import '../ui/now_view.dart';
import '../ui/weekly_view.dart';
import 'city_manager.dart';

class WeatherPage extends StatefulWidget {
  final String cityName;

  WeatherPage(this.cityName, {Key key}) : super(key: key);

  @override
  createState() => WeatherPageState();
}

class WeatherPageState extends State<WeatherPage> {
  HeWeather weather;
  HeWeather airData;

  Air air;
  NowWeather now;
  List<DailyForecast> dailyForecast = [];
  List<Lifestyle> lifestyle = [];
  List<Hourly> hourly = [];

  WeatherType weatherType = WeatherType.sunny;

  ScrollController scrollController = ScrollController();
  double navAlpha = 0;
  double headerHeight = 200;

  Color barColor = Colors.lightBlueAccent;

  bool favorite = false;

  String title;

  @override
  void initState() {
    super.initState();

    title = widget.cityName;

    scrollController.addListener(() {
      var offset = scrollController.offset;
      if (offset <= 0) {
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

    _getWeather(title);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  /// 根据城市名查询该城市天气预报
  _getWeather(String cityName) async {
    airData = await WeatherRepository.getAir(cityName);
    weather = await WeatherRepository.getHeWeather(cityName);

    if (weather != null) {
      now = weather.now;

      weatherType = weatherBg(now?.condCode);
      dailyForecast = weather.dailyForecast;
      lifestyle = weather.lifestyle;
      hourly = weather.hourly;
    }
    if (airData != null) {
      air = airData.airNowCity;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        WeatherBg(
            width: Utils.width, height: Utils.height, weatherType: weatherType),
        _buildContentView(),
        ToolBar(
            title: GestureDetector(
                child: Row(children: <Widget>[
                  Text('$title',
                      style: TextStyle(fontSize: 18.0, color: Colors.white)),
                  Icon(Icons.keyboard_arrow_down, color: Colors.white)
                ], mainAxisSize: MainAxisSize.min),
                onTap: () =>
                    pushNewPage(context, CityPage(), callBack: (value) {
                      if (value != null && title != value) {
                        weather = null;
                        airData = null;

                        setState(() {
                          title = value;
                        });
                        _getWeather(title);
                      }
                    })),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.domain),
                  onPressed: () => pushNewPage(context, CityManagerPage(),
                          callBack: (value) {
                        if (value != null && title != value) {
                          weather = null;
                          airData = null;

                          setState(() {
                            title = value;
                          });
                          _getWeather(title);
                        }
                      })),
              LikeButton(
                  size: 65,
                  normalColor: Colors.white,
                  onClicked: (bool isLiked) {
                    favorite = isLiked;
                  })
            ],
            backgroundColor: Color.fromARGB((navAlpha * 255 * 0.8).toInt(),
                barColor.red, barColor.green, barColor.blue))
      ]),
    );
  }

  Widget _buildContentView() {
    if (null == weather || airData == null) {
      return LoadingWidget();
    }
    return RefreshIndicator(
        child: SingleChildScrollView(
            padding: EdgeInsets.zero,
            controller: scrollController,
            child: Column(children: <Widget>[
              NowView(now, dailyForecast: dailyForecast?.first, air: air),
              air == null ? Container() : AirView(air),
              HourlyView(hourly),
              WeeklyView(dailyForecast),
              lifestyle.length == 0 ? Container() : LifestyleView(lifestyle),
              // SunView(title)
            ])),
        onRefresh: () => _getWeather(title));
  }
}
