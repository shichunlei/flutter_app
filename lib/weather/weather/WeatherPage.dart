import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/utils/loading_util.dart';
import 'package:flutter_app/weather/weather/WeatherData.dart';

class WeatherPage extends StatefulWidget {
  String cityname;

  WeatherPage(this.cityname) : super();

  @override
  State<StatefulWidget> createState() => WeatherPageState();
}

class WeatherPageState extends State<WeatherPage> {
  WeatherData weather;

  @override
  void initState() {
    super.initState();
    _getWeather(widget.cityname);
  }

  /// 根据城市名查询该城市天气预报
  _getWeather(String cityname) async {
    var httpClient = new HttpClient();
    var url =
        "https://free-api.heweather.net/s6/weather/now?key=224bd5b78bd44de19ae8104c201fb1d7&location=${cityname}";

    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == HttpStatus.OK) {
      var jsonData = await response.transform(utf8.decoder).join();

      /// setState 相当于 runOnUiThread
      setState(() {
        weather = WeatherData.decodeData(jsonData.toString());
      });
    }
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
                width: double.infinity,
                margin: EdgeInsets.only(top: 40.0),
                child: Text(
                  widget.cityname,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                  ),
                ),
              ),
              Container(
                height: 80.0,
                child: weather != null
                    ? Image.network(
                        weather.cond_code,
                      )
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
          weather == null
              ? Center(
                  child: getLoadingWidget(),
                )
              : Center(),
        ],
      ),
    );
  }
}
