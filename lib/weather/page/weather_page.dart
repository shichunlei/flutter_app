import 'package:flutter/material.dart';
import 'package:flutter_app/bean/he_weather.dart';
import 'package:flutter_app/service/api_service.dart';
import 'package:flutter_app/utils/loading_util.dart';
import 'package:flutter_app/bean/now.dart';

class WeatherPage extends StatefulWidget {
  final String cityname;

  WeatherPage(this.cityname, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => WeatherPageState();
}

class WeatherPageState extends State<WeatherPage> {
  NowBean now;

  @override
  void initState() {
    super.initState();
    _getWeather(widget.cityname);
  }

  /// 根据城市名查询该城市天气预报
  _getWeather(String cityname) async {
    HeWeather weather = await ApiService.getHeWeatherNow(cityname);

    setState(() {
      if (weather != null) {
        now = weather.now;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            'images/weather_bg.jpg',
            fit: BoxFit.fitHeight,
          ),
          _buildContentView(),
          AppBar(
            backgroundColor: Color(0x00000000),
            elevation: 0,
            title: Text('${widget.cityname}'),
          )
        ],
      ),
    );
  }

  Widget _buildContentView() {
    if (null == now) {
      return getLoadingWidget();
    }
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 100.0),
          height: 80.0,
          child: now != null
              ? Image.network(now.cond_code)
              : Image.asset("images/flutter_logo.png"),
          alignment: Alignment.centerRight,
        ),
        Container(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Text(now != null ? now.tmp : "",
                  style: TextStyle(color: Colors.white, fontSize: 80.0)),
              Text("${now != null ? now.cond_txt : ""}",
                  style: TextStyle(color: Colors.white, fontSize: 45.0)),
              Text(
                now != null ? now.hum : "",
                style: TextStyle(color: Colors.white, fontSize: 30.0),
              )
            ],
          ),
        ),
      ],
    );
  }
}
