import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/global/api.dart';
import 'package:flutter_app/global/config.dart';
import 'package:flutter_app/utils/http_utils.dart';
import 'package:flutter_app/utils/loading_util.dart';
import 'package:flutter_app/weather/bean/now.dart';
import 'package:flutter_app/weather/bean/result.dart';

class WeatherPage extends StatefulWidget {
  String cityname;

  WeatherPage(this.cityname) : super();

  @override
  State<StatefulWidget> createState() => WeatherPageState();
}

class WeatherPageState extends State<WeatherPage> {
  NowBean weather;

  @override
  void initState() {
    super.initState();
    _getWeather(widget.cityname);
  }

  /// 根据城市名查询该城市天气预报
  _getWeather(String cityname) async {
    var data = {
      "location": cityname,
      "key": Config.HE_WEATHER_KEY,
    };

    Response response = await HttpUtils().get(Api.WEATHER, data: data);

    if (response.statusCode == 200) {
      var jsonData = response.data;

      Result result = Result.fromMap(jsonData);

      weather = result.HeWeather6[0].now;
    }

    setState(() {});
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
          Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 100.0),
                height: 80.0,
                child: weather != null
                    ? Image.network(weather.cond_code)
                    : Image.asset("images/flutter_logo.png"),
                alignment: Alignment.centerRight,
              ),
              Container(
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    Text(weather != null ? weather.tmp : "",
                        style: TextStyle(color: Colors.white, fontSize: 80.0)),
                    Text("${weather != null ? weather.cond_txt : ""}",
                        style: TextStyle(color: Colors.white, fontSize: 45.0)),
                    Text(
                      weather != null ? weather.hum : "",
                      style: TextStyle(color: Colors.white, fontSize: 30.0),
                    )
                  ],
                ),
              ),
            ],
          ),
          weather == null ? Center(child: getLoadingWidget()) : Center(),
          AppBar(
            backgroundColor: Color(0x00000000),
            elevation: 0,
            centerTitle: true,
            title: Text('${widget.cityname}'),
          )
        ],
      ),
    );
  }
}
